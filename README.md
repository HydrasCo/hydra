![Hydra - the open source data warehouse](.images/header.svg)

[Request Access](https://hydras.io/#early-access) - [Documentation](https://docs.hydras.io/getting-started/readme) - [Demo](https://www.youtube.com/watch?v=DD1oD1LWNOo) - [Website](https://hydras.io/)

The open source Snowflake alternative. OLAP Postgres.

[Hydra](https://hydras.io/) is an open source data warehouse built on Postgres. It’s easy to use and designed for OLAP and HTAP workloads. Hydra serves analytical reporting with parallelized query execution and vectorization on columnar storage. Operational work and high-throughput transactions write to standard Postgres heap tables. All Postgres extensions, tools, and connectors work with Hydra.

Eliminate data silos today. Solve hard problems fast.

* [x] 🗃 hosted postgres database - [docs](https://docs.hydras.io/getting-started)
* [x] 📎 append-only columnar store - [docs](https://docs.hydras.io/concepts/what-is-columnar)
* [x] 📊 external tables - [docs](https://docs.hydras.io/concepts/using-hydra-external-tables)
* [x] 📅 postgres scheduler - [docs](https://docs.hydras.io/cloud-warehouse-operations/using-hydra-scheduler)
* [x] 🤹‍♀️ query parallelization
* [x] 🐎 vectorized execution of WHERE clauses
* [ ] 📝 updates and deletes for columnar store
* [ ] 🏎️ vectorized execution of aggegate functions
* [ ] 🚅 use of SIMD in vectorized execution
* [ ] ↔️ separation of compute and storage

![Where does Hydra fit](.images/hydra-db.png)

## ⏩ Quick Start

The Hydra [Docker image](https://github.com/hydrasdb/hydra/pkgs/container/hydra) is a drop-in replacement for [postgres Docker image](https://hub.docker.com/_/postgres).

You can also try out Hydra locally using [docker-compose](https://docs.docker.com/compose/).

```
git clone https://github.com/HydrasDB/hydra && cd hydra
cp .env.example .env
docker compose up
psql postgres://postgres:hydra@127.0.0.1:5432
```

### Or

Managed in the [cloud](https://hydras.io/#early-access).

## 📄 Documentation

You can find our documentation [here](https://docs.hydras.io/getting-started/readme).

## 👩🏾‍🤝‍👨🏻 Community

- [Discord chat](https://discord.com/invite/zKpVxbXnNY) for quick questions
- [GitHub Discussions](https://github.com/HydrasDB/hydra/discussions) for longer topics
- [GitHub Issues](https://github.com/HydrasDB/hydra/issues) for bugs and missing features
- [@HydrasDB](https://twitter.com/hydrasdb) on Twitter

## ✅ Status

- [x] Early Access: Closed, private testing
- [ ] Open Alpha: Open for everyone
- [ ] Open Beta: Hydra can handle most non-enterprise use
- [ ] Production: Enterprise ready

We are currently in Early Access. Watch [releases](https://github.com/HydrasDB/hydra/releases) of this repo to get notified of updates.

![follow the repo](.images/follow.gif)

## 🛠 Developing Hydra
Please see [DEVELOPERS.md](DEVELOPERS.md) for information on contributing to Hydra and building the image.

## 📑 License and Acknowledgments
Hydra is only possible by building on the shoulders of giants.

The code in this repo is licensed under the [Apache 2.0 license](LICENSE). Pre-built images are
subject to additional licenses as follows:

* [Hydra columnar engine](https://github.com/HydrasDB/hydra/tree/main/columnar) - AGPL 3.0
* [Spilo](https://github.com/zalando/spilo) - Apache 2.0
* The underlying Spilo image contains a large number of open source projects, including:
  * Postgres - [the Postgres license](https://www.postgresql.org/about/licence/)
  * [WAL-G](https://github.com/wal-g/wal-g) - Apache 2.0
  * [Ubuntu's docker image](https://hub.docker.com/_/ubuntu/) - various copyleft licenses (MIT, GPL, Apache, etc)

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this
image complies with any relevant licenses for all software contained within.
