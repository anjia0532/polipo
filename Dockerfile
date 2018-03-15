FROM alpine
MAINTAINER anjia <anjia0532@gmail.com>

RUN set -xe \
    && echo -e "https://mirrors.ustc.edu.cn/alpine/latest-stable/main\nhttps://mirrors.ustc.edu.cn/alpine/latest-stable/community" > /etc/apk/repositories \
    && apk add --no-cache --virtual .fetch-deps build-base openssl \
    && wget https://github.com/jech/polipo/archive/master.zip -O polipo.zip \
    && unzip polipo.zip \
    && cd polipo-master \
    && make \
    && install polipo /usr/local/bin/ \
    && cd .. \
    && rm -rf polipo.zip polipo-master \
    && mkdir -p /usr/share/polipo/www /var/cache/polipo \
    && apk del .fetch-deps

EXPOSE 8118

#https://www.irif.fr/~jch/software/polipo/polipo.html#Variable-index

ENTRYPOINT ["polipo", "proxyAddress=0.0.0.0", "proxyPort=8118"]
