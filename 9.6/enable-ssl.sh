#!/bin/bash
set -e

if [[ ! -z "$POSTGRES_ENABLE_TLS" && ! $POSTGRES_ENABLE_TLS =~ ^([nN][oO]|[nN]|[fF][aA][lL][sS][eE]|[fF]|0)$ ]] ; then
	if [ ! -f "/etc/ssl/certs/postgresql.crt" ]; then
		cat >&2 <<-'EOWARN'
			****************************************************
			WARNING: Using an auto-generated certificate for TLS.
							 Please consider using your own certificate
							 in production environments.
							 Use "-v /my/cert.crt:/etc/ssl/certs/postgresql.crt"
							 and "-v /my/cert.key:/etc/ssl/private/postgresql.key"
							 to mount your own certificate as a volume.
			****************************************************
		EOWARN
		DEBIAN_FRONTEND=noninteractive make-ssl-cert generate-default-snakeoil --force-overwrite
		cp /etc/ssl/certs/ssl-cert-snakeoil.pem /etc/ssl/certs/postgresql.crt
		cp /etc/ssl/private/ssl-cert-snakeoil.key /etc/ssl/private/postgresql.key
	fi

	cp /etc/ssl/certs/postgresql.crt "$PGDATA/server.crt"
	cp /etc/ssl/private/postgresql.key "$PGDATA/server.key"
	chown postgres "$PGDATA/server.crt"
	chown postgres "$PGDATA/server.key"
	chmod og-rwx "$PGDATA/server.key"

	sed -i "s|#\?ssl \?=.*|ssl = on|g" "$PGDATA/postgresql.conf"
	sed -i 's/host/hostssl/g' "$PGDATA/pg_hba.conf"
fi
