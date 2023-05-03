FROM alpine:3.14

WORKDIR /readsb

# INSTALL RTLSDR DEPENDENCIES, MAKE, AND INSTALL
RUN apk add --no-cache git \
make \
gcc \
libc-dev \
zlib \
zlib-dev \
zstd \
zstd-dev && \
git clone https://github.com/wiedehopf/readsb /tmp/readsb && \
cd /tmp/readsb && \
make DISABLE_INTERACTIVE=yes OPTIMIZE="-O3" && \
apk del make gcc && \
cp readsb /readsb/ && \
rm -rf /tmp/readsb

EXPOSE 30001-30010

RUN ["/readsb/readsb", "--help"]