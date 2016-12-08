FROM hypriot/rpi-alpine-scratch

ENV GNATSD_VERSION 0.9.4

RUN apk add unzip

ADD https://github.com/nats-io/gnatsd/releases/download/v${GNATSD_VERSION}/gnatsd-v${GNATSD_VERSION}-linux-arm.zip /gnatsd.zip

RUN unzip /gnatsd.zip && \
    mv gnatsd-v${GNATSD_VERSION}-linux-arm/gnatsd /gnatsd && \
    rm -fr gnatsd-v${GNATSD_VERSION}-linux-arm /gnatsd.zip && \
    mkdir -p /etc/gnatsd && \
    mkdir -p /var/log/nats

COPY gnatsd.conf /etc/gnatsd/

RUN apk del unzip

EXPOSE 4222 8222 6222

CMD ["/gnatsd", "-c", "/etc/gnatsd/gnatsd.conf"]

