CREATE TABLE big_table (
  id INT,
  firstname TEXT,
  lastname TEXT
) USING columnar;

INSERT INTO big_table (id, firstname, lastname)
  SELECT i,
         CONCAT('firstname-', i),
         CONCAT('lastname-', i)
    FROM generate_series(1, 1000000) as i;

-- get some baselines from multiple chunks
SELECT firstname,
       lastname,
       SUM(id)
  FROM big_table
 WHERE id < 1000
 GROUP BY firstname,
       lastname
UNION
SELECT firstname,
       lastname,
       SUM(id)
  FROM big_table
 WHERE id BETWEEN 15000 AND 16000
 GROUP BY firstname,
       lastname
 ORDER BY firstname;


-- enable caching
SET columnar.enable_column_cache = 't';

-- the results should be the same as above
SELECT firstname,
       lastname,
       SUM(id)
  FROM big_table
 WHERE id < 1000
 GROUP BY firstname,
       lastname
UNION
SELECT firstname,
       lastname,
       SUM(id)
  FROM big_table
 WHERE id BETWEEN 15000 AND 16000
 GROUP BY firstname,
       lastname
 ORDER BY firstname;

-- disable caching
SET columnar.enable_column_cache = 'f';

CREATE TABLE test_2 (
  value INT,
  updated_value INT
) USING columnar;

INSERT INTO test_2 (value)
  SELECT generate_series(1, 1000000, 1);

BEGIN;
SELECT SUM(value)
  FROM test_2;

UPDATE test_2
   SET updated_value = value * 2;

SELECT SUM(updated_value)
  FROM test_2;

DELETE FROM test_2
 WHERE value % 2 = 0;

SELECT SUM(value)
  FROM test_2;
COMMIT;

DROP TABLE test_2;

set columnar.enable_column_cache = 't';

CREATE TABLE test_2 (
  value INT,
  updated_value INT
) USING columnar;

INSERT INTO test_2 (value)
  SELECT generate_series(1, 1000000, 1);

BEGIN;
SELECT SUM(value)
  FROM test_2;

UPDATE test_2
   SET updated_value = value * 2;

SELECT SUM(updated_value)
  FROM test_2;

DELETE FROM test_2
 WHERE value % 2 = 0;

SELECT SUM(value)
  FROM test_2;
COMMIT;

DROP TABLE test_2;

CREATE TABLE t1 (i int) USING columnar;

INSERT INTO t1 SELECT generate_series(1, 1000000, 1);
EXPLAIN SELECT COUNT(*) FROM t1;
DROP TABLE t1;

/* =========================
 * ===test cache eviction===
 * =========================
 */
CREATE TABLE integer_table (
    id SERIAL PRIMARY KEY,
    col1 INTEGER,
    col2 INTEGER,
    col3 INTEGER,
    col4 INTEGER,
    col5 INTEGER,
    col6 INTEGER,
    col7 INTEGER,
    col8 INTEGER,
    col9 INTEGER,
    col10 INTEGER,
    col11 INTEGER,
    col12 INTEGER,
    col13 INTEGER,
    col14 INTEGER,
    col15 INTEGER,
    col16 INTEGER,
    col17 INTEGER,
    col18 INTEGER,
    col19 INTEGER,
    col20 INTEGER,
    col21 INTEGER,
    col22 INTEGER,
    col23 INTEGER,
    col24 INTEGER,
    col25 INTEGER,
    col26 INTEGER,
    col27 INTEGER,
    col28 INTEGER,
    col29 INTEGER,
    col30 INTEGER,
    col31 INTEGER,
    col32 INTEGER,
    col33 INTEGER,
    col34 INTEGER,
    col35 INTEGER,
    col36 INTEGER,
    col37 INTEGER,
    col38 INTEGER,
    col39 INTEGER,
    col40 INTEGER,
    col41 INTEGER,
    col42 INTEGER,
    col43 INTEGER,
    col44 INTEGER,
    col45 INTEGER,
    col46 INTEGER,
    col47 INTEGER,
    col48 INTEGER,
    col49 INTEGER,
    col50 INTEGER,
    col51 INTEGER,
    col52 INTEGER,
    col53 INTEGER,
    col54 INTEGER,
    col55 INTEGER,
    col56 INTEGER,
    col57 INTEGER,
    col58 INTEGER,
    col59 INTEGER,
    col60 INTEGER,
    col61 INTEGER,
    col62 INTEGER,
    col63 INTEGER,
    col64 INTEGER,
    col65 INTEGER,
    col66 INTEGER,
    col67 INTEGER,
    col68 INTEGER,
    col69 INTEGER,
    col70 INTEGER,
    col71 INTEGER,
    col72 INTEGER,
    col73 INTEGER,
    col74 INTEGER,
    col75 INTEGER,
    col76 INTEGER,
    col77 INTEGER,
    col78 INTEGER,
    col79 INTEGER,
    col80 INTEGER,
    col81 INTEGER,
    col82 INTEGER,
    col83 INTEGER,
    col84 INTEGER,
    col85 INTEGER,
    col86 INTEGER,
    col87 INTEGER,
    col88 INTEGER,
    col89 INTEGER,
    col90 INTEGER,
    col91 INTEGER,
    col92 INTEGER,
    col93 INTEGER,
    col94 INTEGER,
    col95 INTEGER,
    col96 INTEGER,
    col97 INTEGER,
    col98 INTEGER,
    col99 INTEGER,
    col100 INTEGER
);

INSERT INTO integer_table (
    col1, col2, col3, col4, col5, col6, col7, col8, col9, col10,
    col11, col12, col13, col14, col15, col16, col17, col18, col19, col20,
    col21, col22, col23, col24, col25, col26, col27, col28, col29, col30,
    col31, col32, col33, col34, col35, col36, col37, col38, col39, col40,
    col41, col42, col43, col44, col45, col46, col47, col48, col49, col50,
    col51, col52, col53, col54, col55, col56, col57, col58, col59, col60,
    col61, col62, col63, col64, col65, col66, col67, col68, col69, col70,
    col71, col72, col73, col74, col75, col76, col77, col78, col79, col80,
    col81, col82, col83, col84, col85, col86, col87, col88, col89, col90,
    col91, col92, col93, col94, col95, col96, col97, col98, col99, col100
)
SELECT
    trunc(random() * 1000)::INTEGER AS col1,
    trunc(random() * 1000)::INTEGER AS col2,
    trunc(random() * 1000)::INTEGER AS col3,
    trunc(random() * 1000)::INTEGER AS col4,
    trunc(random() * 1000)::INTEGER AS col5,
    trunc(random() * 1000)::INTEGER AS col6,
    trunc(random() * 1000)::INTEGER AS col7,
    trunc(random() * 1000)::INTEGER AS col8,
    trunc(random() * 1000)::INTEGER AS col9,
    trunc(random() * 1000)::INTEGER AS col10,
    trunc(random() * 1000)::INTEGER AS col11,
    trunc(random() * 1000)::INTEGER AS col12,
    trunc(random() * 1000)::INTEGER AS col13,
    trunc(random() * 1000)::INTEGER AS col14,
    trunc(random() * 1000)::INTEGER AS col15,
    trunc(random() * 1000)::INTEGER AS col16,
    trunc(random() * 1000)::INTEGER AS col17,
    trunc(random() * 1000)::INTEGER AS col18,
    trunc(random() * 1000)::INTEGER AS col19,
    trunc(random() * 1000)::INTEGER AS col20,
    trunc(random() * 1000)::INTEGER AS col21,
    trunc(random() * 1000)::INTEGER AS col22,
    trunc(random() * 1000)::INTEGER AS col23,
    trunc(random() * 1000)::INTEGER AS col24,
    trunc(random() * 1000)::INTEGER AS col25,
    trunc(random() * 1000)::INTEGER AS col26,
    trunc(random() * 1000)::INTEGER AS col27,
    trunc(random() * 1000)::INTEGER AS col28,
    trunc(random() * 1000)::INTEGER AS col29,
    trunc(random() * 1000)::INTEGER AS col30,
    trunc(random() * 1000)::INTEGER AS col31,
    trunc(random() * 1000)::INTEGER AS col32,
    trunc(random() * 1000)::INTEGER AS col33,
    trunc(random() * 1000)::INTEGER AS col34,
    trunc(random() * 1000)::INTEGER AS col35,
    trunc(random() * 1000)::INTEGER AS col36,
    trunc(random() * 1000)::INTEGER AS col37,
    trunc(random() * 1000)::INTEGER AS col38,
    trunc(random() * 1000)::INTEGER AS col39,
    trunc(random() * 1000)::INTEGER AS col40,
    trunc(random() * 1000)::INTEGER AS col41,
    trunc(random() * 1000)::INTEGER AS col42,
    trunc(random() * 1000)::INTEGER AS col43,
    trunc(random() * 1000)::INTEGER AS col44,
    trunc(random() * 1000)::INTEGER AS col45,
    trunc(random() * 1000)::INTEGER AS col46,
    trunc(random() * 1000)::INTEGER AS col47,
    trunc(random() * 1000)::INTEGER AS col48,
    trunc(random() * 1000)::INTEGER AS col49,
    trunc(random() * 1000)::INTEGER AS col50,
    trunc(random() * 1000)::INTEGER AS col51,
    trunc(random() * 1000)::INTEGER AS col52,
    trunc(random() * 1000)::INTEGER AS col53,
    trunc(random() * 1000)::INTEGER AS col54,
    trunc(random() * 1000)::INTEGER AS col55,
    trunc(random() * 1000)::INTEGER AS col56,
    trunc(random() * 1000)::INTEGER AS col57,
    trunc(random() * 1000)::INTEGER AS col58,
    trunc(random() * 1000)::INTEGER AS col59,
    trunc(random() * 1000)::INTEGER AS col60,
    trunc(random() * 1000)::INTEGER AS col61,
    trunc(random() * 1000)::INTEGER AS col62,
    trunc(random() * 1000)::INTEGER AS col63,
    trunc(random() * 1000)::INTEGER AS col64,
    trunc(random() * 1000)::INTEGER AS col65,
    trunc(random() * 1000)::INTEGER AS col66,
    trunc(random() * 1000)::INTEGER AS col67,
    trunc(random() * 1000)::INTEGER AS col68,
    trunc(random() * 1000)::INTEGER AS col69,
    trunc(random() * 1000)::INTEGER AS col70,
    trunc(random() * 1000)::INTEGER AS col71,
    trunc(random() * 1000)::INTEGER AS col72,
    trunc(random() * 1000)::INTEGER AS col73,
    trunc(random() * 1000)::INTEGER AS col74,
    trunc(random() * 1000)::INTEGER AS col75,
    trunc(random() * 1000)::INTEGER AS col76,
    trunc(random() * 1000)::INTEGER AS col77,
    trunc(random() * 1000)::INTEGER AS col78,
    trunc(random() * 1000)::INTEGER AS col79,
    trunc(random() * 1000)::INTEGER AS col80,
    trunc(random() * 1000)::INTEGER AS col81,
    trunc(random() * 1000)::INTEGER AS col82,
    trunc(random() * 1000)::INTEGER AS col83,
    trunc(random() * 1000)::INTEGER AS col84,
    trunc(random() * 1000)::INTEGER AS col85,
    trunc(random() * 1000)::INTEGER AS col86,
    trunc(random() * 1000)::INTEGER AS col87,
    trunc(random() * 1000)::INTEGER AS col88,
    trunc(random() * 1000)::INTEGER AS col89,
    trunc(random() * 1000)::INTEGER AS col90,
    trunc(random() * 1000)::INTEGER AS col91,
    trunc(random() * 1000)::INTEGER AS col92,
    trunc(random() * 1000)::INTEGER AS col93,
    trunc(random() * 1000)::INTEGER AS col94,
    trunc(random() * 1000)::INTEGER AS col95,
    trunc(random() * 1000)::INTEGER AS col96,
    trunc(random() * 1000)::INTEGER AS col97,
    trunc(random() * 1000)::INTEGER AS col98,
    trunc(random() * 1000)::INTEGER AS col99,
    trunc(random() * 1000)::INTEGER AS col100
FROM generate_series(1, 60000);

-- size should be greater 25Mb
SELECT pg_size_pretty(pg_table_size('integer_table')) AS table_size;

-- prepare conversion to columnar (will be error, if not to drop)
DROP SEQUENCE integer_table_id_seq CASCADE;

--with 'copy_integer_table' we will compare integer_table after conversions
CREATE TABLE copy_integer_table AS
SELECT *
FROM integer_table;

--convert 'integer_table' to columnar
SELECT columnar.alter_table_set_access_method('integer_table','columnar');

-- check table size
SELECT pg_size_pretty(pg_table_size('integer_table')) AS table_size;

-- set caching GUCs 
-- should be 200. If no, correct below 'SET columnar.column_cache_size = 200'
SHOW columnar.column_cache_size;
SET columnar.column_cache_size = 20;
SET columnar.enable_column_cache = 't';

SELECT columnar.alter_table_set_access_method('integer_table', 'heap');
SELECT pg_size_pretty(pg_table_size('integer_table')) AS table_size;

-- Check table contents are the same after conversion heap->columnar->heap
SELECT * FROM integer_table
EXCEPT
SELECT * FROM copy_integer_table;

SELECT * FROM copy_integer_table
EXCEPT
SELECT * FROM integer_table;

SELECT COUNT(*) FROM integer_table
EXCEPT
SELECT COUNT(*) FROM copy_integer_table;

-- cleaning
DROP TABLE integer_table;
DROP TABLE copy_integer_table;
-- restore caching GUCs
SET columnar.enable_column_cache = 'f';
SET columnar.column_cache_size = 200;
