FROM alpine:3.9

LABEL description="Jpsonic is a free, web-based media streamer, providing ubiquitious access to your music." \
      url="https://github.com/tesshucom/jpsonic" \
      maintainer="https://github.com/orumin/jpsonic"

ARG VERSION=v107.0.0

ENV JPSONIC_PORT=4040 JPSONIC_DIR=/jpsonic CONTEXT_PATH=/

WORKDIR $JPSONIC_DIR

RUN apk --no-cache add \
    ffmpeg \
    lame \
    bash \
    libressl \
    fontconfig \
    ttf-dejavu \
    ca-certificates \
    tini \
    curl \
    openjdk8-jre \
    nss \
 && apk add --no-cache --virtual .build-deps \
    maven \
    openjdk8 \
    git \
 && git clone https://github.com/jpsonic/jpsonic \
 && cd jpsonic \
 && git checkout $VERSION \
 && mvn clean package -Dmaven.test.skip=true \
 && mv jpsonic-main/target/jpsonic.war $JPSONIC_DIR/jpsonic.war \
 && cd .. \
 && rm -rf /root/.m2 $JPSONIC_DIR/jpsonic \
 && apk del --purge .build-deps

COPY run.sh /usr/local/bin/run.sh

RUN chmod +x /usr/local/bin/run.sh

EXPOSE $JPSONIC_PORT

VOLUME $JPSONIC_DIR/data $JPSONIC_DIR/music $JPSONIC_DIR/playlists $JPSONIC_DIR/podcasts

HEALTHCHECK --interval=15s --timeout=3s CMD wget -q http://localhost:"$JPSONIC_PORT""$CONTEXT_PATH"rest/ping -O /dev/null || exit 1

ENTRYPOINT ["tini", "--", "run.sh"]
