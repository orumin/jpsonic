FROM alpine:3.12 AS jpsonic-build

ARG VERSION=v109.2.0

RUN apk add --no-cache \
    maven \
    patch \
    openjdk11-jdk \
    git

RUN git clone https://github.com/jpsonic/jpsonic \
 && cd jpsonic \
 && git checkout $VERSION \
 && mvn clean package -Prelease11 -Pjetty-embed -Dmaven.test.skip=true -Dpmd.skip=true

FROM alpine:3.12

LABEL description="Jpsonic is a free, web-based media streamer, providing ubiquitious access to your music." \
      url="https://github.com/tesshucom/jpsonic" \
      maintainer="https://github.com/orumin/jpsonic"

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
    openjdk11-jre \
    nss

COPY --from=jpsonic-build /jpsonic/jpsonic-main/target/jpsonic.war $JPSONIC_DIR/jpsonic.war

COPY run.sh /usr/local/bin/run.sh

RUN chmod +x /usr/local/bin/run.sh

EXPOSE $JPSONIC_PORT

VOLUME $JPSONIC_DIR/data $JPSONIC_DIR/music $JPSONIC_DIR/playlists $JPSONIC_DIR/podcasts

HEALTHCHECK --interval=15s --timeout=3s CMD wget -q http://localhost:"$JPSONIC_PORT""$CONTEXT_PATH"rest/ping -O /dev/null || exit 1

ENTRYPOINT ["tini", "--", "run.sh"]
