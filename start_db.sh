#!/bin/sh
set -e

POSTGRES_OPTIONS="-c config_file=/etc/postgresql/postgresql.conf"

# Externally mounted volumes are owned by root, make sure the data directory
# is owned by postgres user inside the container
echo "\n===== Modifying ownership/permissions of data directories ====="
chown -R postgres "/var/lib/postgresql"

# Check if this is the first time running
if [ ! -s "$PGDATA/PG_VERSION" ]; then

    echo "\n============= Initializing Postgres Data Directory ============"
    gosu postgres initdb

    echo "\n=============== Starting Postgres in Background ==============="
    gosu postgres postgres $POSTGRES_OPTIONS &
    POSTGRES_PID="$!"
    sleep 5  # wait for postgres to start up before using psql

    echo "\n==================== Configuring Postgres ====================="
    gosu postgres psql --command "ALTER ROLE postgres WITH PASSWORD 'postgres';"


    if [ "$POSTGRES_USER" ] && [ "$POSTGRES_PASSWORD" ]; then
        echo "Creating user $POSTGRES_USER"
        gosu postgres psql --command "CREATE USER $POSTGRES_USER WITH SUPERUSER PASSWORD '$POSTGRES_PASSWORD'"
    fi

    if [ "$POSTGRES_DB" ]; then
        echo "Creating Database $POSTGRES_DB"
        gosu postgres psql --command "CREATE DATABASE $POSTGRES_DB"
        gosu postgres psql -d $POSTGRES_DB --command "CREATE EXTENSION IF NOT EXISTS postgis"
        gosu postgres psql -d $POSTGRES_DB --command "CREATE EXTENSION IF NOT EXISTS postgis_topology"
    fi

    echo "\n============ Stopping Postgres Background Process ============="
    kill -2 "$POSTGRES_PID"
    sleep 5  # wait for postgres to exit before restarting

fi

echo "\n=============== Starting Postgres in foreground ==============="
gosu postgres postgres $POSTGRES_OPTIONS
