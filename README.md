# docker-postgis

This repository contains a collection of templated `Dockerfile` for image variants designed to support PostGIS through PostgreSQL.

## Usage

### Template Variables

- `POSTGIS_MAJOR` - Major version number of PostGIS
- `POSTGIS_VERSION` - Version number for `postgresql-X.X-postgis-X.X` package
- `PG_MAJOR` - Major version number of the target PostgreSQL database instance
- `VARIANT` - Base container image variant

### Environment Variables

Because this image builds on the PostgreSQL container image, it supports the same environment variables. While none of these variables are required, they may aid you in using the image.

#### `POSTGRES_PASSWORD`

This environment variable is recommended for you to use the PostgreSQL image. This environment variable sets the superuser password for PostgreSQL. The default superuser is defined by the `POSTGRES_USER` environment variable. In the above example, it is being set to "mysecretpassword".

#### `POSTGRES_USER`

This optional environment variable is used in conjunction with `POSTGRES_PASSWORD` to set a user and its password. This variable will create the specified user with superuser power and a database with the same name. If it is not specified, then the default user of `postgres` will be used.

#### `PGDATA`

This optional environment variable can be used to define another location - like a subdirectory - for the database files. The default is `/var/lib/postgresql/data`, but if the data volume you're using is a fs mountpoint (like with GCE persistent disks), Postgres `initdb` recommends a subdirectory (for example `/var/lib/postgresql/data/pgdata` ) be created to contain the data.

#### `POSTGRES_DB`

This optional environment variable can be used to define a different name for the default database that is created when the image is first started. If it is not specified, then the value of `POSTGRES_USER` will be used.

#### `POSTGRES_INITDB_ARGS`

This optional environment variable can be used to send arguments to `postgres initdb`. The value is a space separated string of arguments as `postgres initdb` would expect them. This is useful for adding functionality like data page checksums: `-e POSTGRES_INITDB_ARGS="--data-checksums"`.

### Testing

An example of how to use `cibuild` to build and test an image:

```bash
$ CI=1 POSTGIS_MAJOR=2.2 POSTGIS_VERSION=2.3.2+dfsg-1~exp1.pgdg80+1 \
  PG_MAJOR=9.5 VARIANT=slim \
  ./scripts/cibuild
```

