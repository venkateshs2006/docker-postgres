# postgres

Docker image which adds postgis and TLS support to the official image.

Note that while using this image, a TLS connection is mandatory. Run with `-e POSTGRES_ENABLE_TLS=no` to disable TLS.

By default, an TLS certificate is auto-generated at each boot.  Please consider using your own certificate in production environments.
Use `-v /my/cert.crt:/etc/ssl/certs/postgresql.crt` and `-v /my/cert.key:/etc/ssl/private/postgresql.key` to mount your own certificate as a volume.
