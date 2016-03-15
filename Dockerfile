FROM postgres:9.5

RUN apt-get update && \
    apt-get install -y postgresql-9.5-postgis-2.2 && \
    rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /
