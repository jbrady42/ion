FROM node:lts-alpine

ENV ENABLE_TELEMETRY="false"
RUN mkdir -p /app/demo

# SDK
WORKDIR /usr/src/ion
COPY ./sdk/js/package.json /usr/src/ion/
RUN npm install

# APP
WORKDIR /usr/src/ion/demo
COPY ./sdk/js/demo/package.json /usr/src/ion/demo/
RUN npm install

COPY ./sdk/js /usr/src/ion
RUN npm run build


FROM caddy:2.0.0-rc.3-alpine
RUN mkdir -p /app/demo
COPY --from=0 /usr/src/ion/demo/dist /app/demo/dist
