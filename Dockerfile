FROM nginx:mainline-alpine-slim

EXPOSE 443

COPY ./default.conf /etc/nginx/conf.d/default.conf

COPY ./40-ensure-ssl-reverse-proxy.sh /docker-entrypoint.d/40-ensure-ssl-reverse-proxy.sh
