FROM postgres:9.4.1

RUN apt-get update && \
    apt-get install postgresql-9.4-postgis-2.1 && \
    rm -rf /var/lib/apt/lists/*
