FROM nginx:alpine

WORKDIR /usr/share/nginx/html
RUN apk add --no-cache curl

ARG RIOT_VERSION
ARG CHATONS_SERVICE
ARG CHATONS_DOMAIN

RUN curl -sSL https://github.com/vector-im/riot-web/releases/download/$RIOT_VERSION/riot-$RIOT_VERSION.tar.gz \
  | tar -xz --strip-components=1
RUN mv config.sample.json config.json \
 && sed -i "/default_hs_url/s/https:\/\/matrix.org/\/\/$CHATONS_SERVICE.$CHATONS_DOMAIN/" config.json \
 && sed -i "/integrations_ui_url/s/https:\/\/scalar.vector.im\//\/\/dimension.${CHATONS_DOMAIN}\/riot/" config.json \
 && sed -i "/integrations_rest_url/s/https:\/\/scalar.vector.im\/api/\/\/dimension.${CHATONS_DOMAIN}\/api\/v1\/scalar/" config.json \
 && sed -i "/integrations_jitsi_widget_url/s/https:\/\/scalar.vector.im\/api\/widgets\/jitsi.html/\/\/dimension.${CHATONS_DOMAIN}\/widgets\/jitsi/" config.json
