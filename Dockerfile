FROM ubuntu:focal

WORKDIR /readsb

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

# INSTALL RTLSDR DEPENDENCIES, MAKE, AND INSTALL
RUN apt update && \
apt install --no-install-recommends --no-install-suggests -y \
git \
ca-certificates \
curl \
make \
cmake \ 
gcc \
libc-dev \
pkg-config \
libusb-1.0-0-dev \
libusb-1.0-0 \
libncurses5-dev \
zlib1g-dev \
zlib1g \
libzstd-dev \
libzstd1 && \
git clone https://github.com/wiedehopf/readsb && \
make && \
apt remove -y \
git \
ca-certificates \
curl \
make \
cmake \
gcc \
libc-dev \
pkg-config \
libusb-1.0-0-dev \
zlib1g-dev \
libzstd-dev && \
apt autoremove -y && \
rm -rf /readsb/rtl-sdr /var/lib/apt/lists/*

EXPOSE 30001 30002 30003 30004 30005 30006 30007 30008 30009 30010

RUN ["/readsb/readsb", "--help"]
