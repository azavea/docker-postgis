FROM postgres:9.6

MAINTAINER Azavea <systems@azavea.com>

ENV POSTGIS_MAJOR 2.3
ENV POSTGIS_VERSION 2.3.0*pgdg80+1

RUN \
    apt-get update && apt-get install -y --no-install-recommends \
            postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
            postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts \
	&& rm -rf /var/lib/apt/lists/*
