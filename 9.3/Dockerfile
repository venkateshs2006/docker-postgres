FROM postgres:9.3

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql-9.3-postgis-2.2 ssl-cert && \
    rm -rf /var/lib/apt/lists/*

COPY enable-ssl.sh /docker-entrypoint-initdb.d/enable-ssl.sh
