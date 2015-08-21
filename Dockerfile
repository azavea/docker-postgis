FROM debian:jessie

MAINTAINER Azavea

ENV LANG en_US.utf8
ENV PG_MAJOR 9.4
ENV PG_VERSION 9.4.4-1.pgdg80+1
ENV POSTGIS_MAJOR 2.1
ENV POSTGIS_VERSION 2.1.7*pgdg80+1

# Install gosu, set locale
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    apt-get update && \
    apt-get install -y --no-install-recommends locales ca-certificates wget && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" &&\
    wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" &&\
    gpg --verify /usr/local/bin/gosu.asc &&\
    rm /usr/local/bin/gosu.asc && \
    chmod +x /usr/local/bin/gosu && \
    apt-get purge -y --auto-remove ca-certificates wget && \
    rm -rf /var/lib/apt/lists/*

# Install postgres and postgis
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 && \
    apt-get update && \
    apt-get install -y --no-install-recommends postgresql-$PG_MAJOR=$PG_VERSION \
    postgresql-contrib-$PG_MAJOR=$PG_VERSION \
    postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR \
    postgis=$POSTGIS_VERSION && \
    rm -rf /var/lib/apt/lists/*

# Set path for initidb
ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH

# Copy config files
COPY /etc/postgresql/pg_hba.conf /etc/postgresql/pg_hba.conf
COPY /etc/postgresql/postgresql.conf /etc/postgresql/postgresql.conf

# Persist data volume
ENV PGDATA /var/lib/postgresql/data
VOLUME /var/lib/postgresql/data

EXPOSE 5432
COPY start_db.sh /start_db.sh
CMD ["/start_db.sh"]
