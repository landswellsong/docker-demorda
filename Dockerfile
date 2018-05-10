# На базе: https://hub.docker.com/r/bitnn/alpine-xmrig/
FROM alpine:latest 

# Виніс сюди, підставте, що треба 
ENV LIBUV_BRANCH="v1.11.0"
ENV XMRIG_BRANCH="v2.5.3"

RUN   adduser -S -D -H -h /miner miner && \
      mkdir /miner && \
      apk --no-cache upgrade && \
      apk --no-cache add --virtual .build-deps \
        git \
        cmake \
        libtool \
        m4 \
        automake \
        autoconf \
        build-base && \
      git clone --branch ${LIBUV_BRANCH} https://github.com/libuv/libuv && \
        cd libuv && sh autogen.sh && \
        ./configure --prefix /libuv/build --enable-static=yes --enable-shared=no && \
        make && make install && \
        cd - && \
      git clone --branch ${XMRIG_BRANCH} https://github.com/xmrig/xmrig && \
        cd xmrig && \
        mkdir build && cd build && \
        cmake -DCMAKE_BUILD_TYPE=Release \
          -DWITH_HTTPD=OFF \
          -DXMRIG_DEPS=/libuv/build .. && \
        make && cp xmrig /miner && \
        apk del .build-deps && \
        rm -fr /var/cache/apk/* /xmrig /libuv
USER miner 
WORKDIR /miner

ADD config.json /miner
ENTRYPOINT ["./xmrig"]
