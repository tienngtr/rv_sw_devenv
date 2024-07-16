FROM ubuntu:24.04

RUN DEBIAN_FRONTEND=noninteractive && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install autoconf automake autotools-dev curl python3 python3-pip libmpc-dev libmpfr-dev \
    libgmp-dev gawk build-essential bison flex texinfo gperf libtool \
    patchutils bc zlib1g-dev libexpat-dev git ninja-build cmake libglib2.0-dev expect \
    device-tree-compiler python3-pyelftools libslirp-dev

