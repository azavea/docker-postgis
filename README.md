# docker-postgis

[![Docker Repository on Quay.io](https://quay.io/repository/azavea/postgis/status "Docker Repository on Quay.io")](https://quay.io/repository/azavea/postgis)
[![Apache V2 License](http://img.shields.io/badge/license-Apache%20V2-blue.svg)](https://github.com/azavea/docker-postgis/blob/master/LICENSE)

A `Dockerfile` based off of [`debian:jessie`](https://hub.docker.com/_/debian/) that installs Postgres and PostGIS. This is a basic image that can be used for the development of geospatial applications that require access to a PostGIS enabled database. This image _should_ _not_ be used in production, it is intended for local development only.

## Usage

First, build the container:

```bash
$ docker build -t azavea/postgis .
```

When running this container you can optionally pass in environment variables to create a spatially enabled database, user, and password.

| Environment Variable  | Usage                                        |
|-----------------------|----------------------------------------------|
| `POSTGRES_USER`       | User to create on first container startup    |
| `POSTGRES_PASSWORD`   | Password for to authenticate `POSTGRES_USER` |
| `POSTGRES_DB`         | Database to create and enable PostGIS        |

```bash
$ docker run -it --rm azavea/postgis \
-p 5432:5432 \
-e POSTGRES_USER=test_user \
-e POSTGRES_PASSWORD=test_password \
-e POSTGRES_DB=test_db .
```

To persist data on a host volume, mount the volume at `/var/lib/postgresql/data`:

```bash
$ docker run -it --rm azavea/postgis \
-p 5432:5432 \
-e POSTGRES_USER=test_user \
-e POSTGRES_PASSWORD=test_password \
-e POSTGRES_DB=test_db \
-v $(pwd)/data:/var/lib/postgresql/data .
```

## Versioning
Versions of this container increment based on the following factors:
 - changes to any configuration files in this repository
 - changes to any dependencies or libraries installed in Dockerfile

If you are looking for a specific version of Postgres or PostGIS the following table describes the relationship between this repository's version and the versions of Postgres and PostGIS.

| docker-postgis version | Postgres version | PostGIS version |
|------------------------|------------------|-----------------|
| 0.1.0                  | 9.4.4            | 2.1.7           |
