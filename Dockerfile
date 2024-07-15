FROM ubuntu:24.04 AS toolchain-builder

RUN DEBIAN_FRONTEND=noninteractive && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install autoconf automake autotools-dev curl python3 python3-pip libmpc-dev libmpfr-dev \
    libgmp-dev gawk build-essential bison flex texinfo gperf libtool \
    patchutils bc zlib1g-dev libexpat-dev git ninja-build cmake libglib2.0-dev expect \
    device-tree-compiler python3-pyelftools libslirp-dev

ARG PREFIX=/opt/riscv
RUN mkdir -p $PREFIX

RUN cd && git clone --depth=1 --single-branch https://github.com/riscv-collab/riscv-gnu-toolchain.git
WORKDIR /root/riscv-gnu-toolchain
RUN git submodule init binutils gcc gdb glibc newlib qemu spike && \
    git submodule update --recursive --progress --depth=1 -j 7

RUN ./configure --prefix=$PREFIX
RUN make -j$(nproc)
