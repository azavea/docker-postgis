FROM postgres:9.5

MAINTAINER Azavea <systems@azavea.com>

ENV POSTGIS_MAJOR 2.2
ENV POSTGIS_VERSION 2.2.2*pgdg80+1

RUN \
    apt-get update && apt-get install -y --no-install-recommends \
            postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
	&& rm -rf /var/lib/apt/lists/*
