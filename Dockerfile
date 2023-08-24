#syntax=docker/dockerfile:1

FROM postgres_base

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
  curl \
  ca-certificates \
  ; \
  rm -rf /var/lib/apt/lists/*

# columnar ext
# NOTE(owenthereal): move columnar out to a separate repo so that we don't have a circular dependency between pgxman & this repo
COPY --from=columnar /pg_ext /

COPY files/postgres/docker-entrypoint-initdb.d /docker-entrypoint-initdb.d/

ARG POSTGRES_BASE_VERSION
# Always force rebuild of this layer
ARG TIMESTAMP=1
COPY third-party/pgxman /tmp/pgxman/
RUN set -eux; \
  /tmp/pgxman/install.sh /tmp/pgxman/pgxman_${POSTGRES_BASE_VERSION}.yaml; \
  pgxman install pgsql-http=1.5.0@${POSTGRES_BASE_VERSION}; \
  rm -rf /tmp/pgxman
