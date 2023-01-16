# Looking for information on environment variables?
# We don't declare them here — take a look at our docs.
# https://github.com/swagger-api/swagger-ui/blob/master/docs/usage/configuration.md

FROM nginx:1.21.6-alpine

RUN apk update && apk add --no-cache "nodejs>=14.17.6-r0"

LABEL maintainer="fehguy"

ENV API_KEY "**None**"
COPY ./swagger.json /usr
ENV SWAGGER_JSON "/usr/swagger.json"
ENV PORT 8080
ENV BASE_URL "/docs"
ENV SWAGGER_JSON_URL ""

COPY ./docker/nginx.conf ./docker/cors.conf /etc/nginx/

# copy swagger files to the `/js` folder
COPY ./dist/* /usr/share/nginx/html/
COPY ./docker/docker-entrypoint.d/ /docker-entrypoint.d/
COPY ./docker/configurator /usr/share/nginx/configurator

RUN chmod -R a+rw /usr/share/nginx && \
    chmod -R a+rw /etc/nginx && \
    chmod -R a+rw /var && \
    chmod -R a+rw /var/run

EXPOSE 8080
