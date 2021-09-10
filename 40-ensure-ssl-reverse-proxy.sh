#!/bin/sh

DEFAULT_CONF_FILE="etc/nginx/conf.d/default.conf"
CERT_DIR="/etc/ssl/private/"

if [ ! -r "$CERT_DIR/cert.key" ]; then
    openssl ecparam -genkey -name prime256v1 -out $CERT_DIR/cert.key
    chmod 644 $CERT_DIR/cert.key
fi
if [ ! -r "$CERT_DIR/cert.crt" ]; then
    EXT_ADDR="localhost"
    if [ ! -z "${EXT_ACCESS}"  ]; then
        EXT_ADDR=`curl ifconfig.co/`|| "localhost"
    fi
    openssl req -x509 -sha256 -subj "/C=IL/CN=home/OU=lan" -addext "subjectAltName = DNS:$EXT_ADDR" -key $CERT_DIR/cert.key -nodes -out $CERT_DIR/cert.crt
    chmod 644 $CERT_DIR/cert.crt
fi

[ -z "${FRWRD_TO}" ] || sed -i "s/localhost:8080/$FRWRD_TO/" /$DEFAULT_CONF_FILE
