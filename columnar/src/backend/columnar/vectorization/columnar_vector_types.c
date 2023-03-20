/*-------------------------------------------------------------------------
 *
 * columnar_vector_types.c
 *
 * Copyright (c) Hydra, Inc.
 *
 * $Id$
 *
 *-------------------------------------------------------------------------
 */

#include "postgres.h"

#include "utils/lsyscache.h"
#include "nodes/bitmapset.h"

#include "columnar/columnar.h"
#include "columnar/vectorization/columnar_vector_types.h"

VectorColumn *
BuildVectorColumn(int16 columnDimension, int16 columnTypeLen, 
				  bool columnIsVal, uint64 *rowNumber)
{
	VectorColumn *vectorColumn;

	vectorColumn = palloc0(sizeof(VectorColumn));

	vectorColumn->dimension = 0;
	vectorColumn->value = palloc0(columnTypeLen * COLUMNAR_VECTOR_COLUMN_SIZE);
	vectorColumn->columnTypeLen = columnTypeLen;
	vectorColumn->columnIsVal = columnIsVal;
	vectorColumn->rowNumber = rowNumber;

	return vectorColumn;
}

TupleTableSlot * 
CreateVectorTupleTableSlot(TupleDesc tupleDesc)
{
	int						i;
	TupleTableSlot			*slot;
	VectorTupleTableSlot	*vectorTTS;
	VectorColumn			*vectorColumn;

	static TupleTableSlotOps tts_ops;
	tts_ops = TTSOpsVirtual;
	tts_ops.base_slot_size = sizeof(VectorTupleTableSlot);

	slot = MakeTupleTableSlot(CreateTupleDescCopy(tupleDesc), &tts_ops);

	TupleDesc slotTupleDesc  = slot->tts_tupleDescriptor;

	/* Vectorized TTS */
	vectorTTS = (VectorTupleTableSlot*) slot;
	
	/* All tuples should be skipped in initialization */
	memset(vectorTTS->skip, true, sizeof(vectorTTS->skip));

	for (i = 0; i < slotTupleDesc->natts; i++)
	{		
		Oid columnTypeOid = TupleDescAttr(slotTupleDesc, i)->atttypid;
		
		int16 columnTypeLen = get_typlen(columnTypeOid);

		int16 vectorColumnTypeLen = 
			columnTypeLen == -1 ?  sizeof(Datum) : get_typlen(columnTypeOid);

		/* 
		 * We consider that type is passed by val also for cases where we have 
		 * typlen == -1. This is because we use pointer to VARLEN type and don't
		 * construct our own object.
		*/
		bool vectorColumnIsVal = vectorColumnTypeLen <= sizeof(Datum);

		vectorColumn = BuildVectorColumn(COLUMNAR_VECTOR_COLUMN_SIZE,
										 vectorColumnTypeLen,
										 vectorColumnIsVal,
										 vectorTTS->rowNumber);

		vectorTTS->tts.tts_values[i] = PointerGetDatum(vectorColumn);
		vectorTTS->tts.tts_isnull[i] = false;
	}

	return slot;
}


void
extractTupleFromVectorSlot(TupleTableSlot *out, VectorTupleTableSlot *vectorSlot, 
						   int32 index, Bitmapset *attrNeeded)
{
	int bmsMember = -1;
	while ((bmsMember = bms_next_member(attrNeeded, bmsMember)) >= 0)
	{
		VectorColumn *column = (VectorColumn *) vectorSlot->tts.tts_values[bmsMember];

		int8 *rawColumRawData = (int8*) column->value + column->columnTypeLen * index;

		out->tts_values[bmsMember] = fetch_att(rawColumRawData, column->columnIsVal, column->columnTypeLen);
		out->tts_isnull[bmsMember] = column->isnull[index];
	}

	out->tts_tid = row_number_to_tid(vectorSlot->rowNumber[index]);

	ExecStoreVirtualTuple(out);
}