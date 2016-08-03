# docker-postgis

[![Docker Repository on Quay.io](https://quay.io/repository/azavea/postgis/status "Docker Repository on Quay.io")](https://quay.io/repository/azavea/postgis)
[![Apache V2 License](http://img.shields.io/badge/license-Apache%20V2-blue.svg)](https://github.com/azavea/docker-postgis/blob/develop/LICENSE)

A `Dockerfile` based off of [`postgres`](https://hub.docker.com/_/postgres/) that installs the PostGIS extension to PostgreSQL. This image **should not** be used in production, it is intended for local development only.

## Usage

First, build the container:

```bash
$ docker build -t quay.io/azavea/postgis:latest .
```

Then, create an instance with the default `postgres` superuser:

```bash
$ docker run -d -p 5432:5432 quay.io/azavea/postgis:latest
```

## Environment Variables

Because this image builds on the PostgreSQL container image, it supports the same environment variables. While none of these variables are required, they may aid you in using the image.

### `POSTGRES_PASSWORD`

This environment variable is recommended for you to use the PostgreSQL image. This environment variable sets the superuser password for PostgreSQL. The default superuser is defined by the `POSTGRES_USER` environment variable. In the above example, it is being set to "mysecretpassword".

### `POSTGRES_USER`

This optional environment variable is used in conjunction with `POSTGRES_PASSWORD` to set a user and its password. This variable will create the specified user with superuser power and a database with the same name. If it is not specified, then the default user of `postgres` will be used.

### `PGDATA`

This optional environment variable can be used to define another location - like a subdirectory - for the database files. The default is `/var/lib/postgresql/data`, but if the data volume you're using is a fs mountpoint (like with GCE persistent disks), Postgres `initdb` recommends a subdirectory (for example `/var/lib/postgresql/data/pgdata` ) be created to contain the data.

### `POSTGRES_DB`

This optional environment variable can be used to define a different name for the default database that is created when the image is first started. If it is not specified, then the value of `POSTGRES_USER` will be used.

### `POSTGRES_INITDB_ARGS`

This optional environment variable can be used to send arguments to `postgres initdb`. The value is a space separated string of arguments as `postgres initdb` would expect them. This is useful for adding functionality like data page checksums: `-e POSTGRES_INITDB_ARGS="--data-checksums"`.

## Versioning

Previous versions of this container changed versions based on the following factors:

 - Changes to any configuration files in this repository
 - Changes to any dependencies or libraries installed in Dockerfile

If you are looking for a specific version of Postgres or PostGIS the following table describes the relationship between this repository's version and the versions of Postgres and PostGIS:

| `docker-postgis` version | PostgreSQL version | PostGIS version |
|------------------------|------------------|-----------------|
| 0.1.0                  | 9.4.4            | 2.1.7           |
| 0.2.0                  | 9.5.3            | 2.2.2           |
