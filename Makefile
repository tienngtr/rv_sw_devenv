.PHONY: all toolchain toolchain-builder toolchain-src

DOCKER=podman

all: toolchain

toolchain: toolchain-builder toolchain-src

toolchain-builder:
	$(DOCKER) build -t $@ -f container/toolchain.Containerfile container

toolchain-src:
	git submodule update --progress --init --depth=1 --single-branch riscv-gnu-toolchain
	git -C riscv-gnu-toolchain submodule init binutils gcc gdb glibc newlib qemu spike
	git -C riscv-gnu-toolchain submodule update --progress --recursive --depth=1 --single-branch -j 7
