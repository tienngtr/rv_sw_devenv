.PHONY: all toolchain toolchain-builder toolchain-src

DOCKER=podman

all: toolchain

toolchain: toolchain-builder toolchain-src

toolchain-builder:
	$(DOCKER) build -t $@ -f container/toolchain.Containerfile container

toolchain-src:
	git submodule update --progress --init --depth=1 --single-branch riscv-gnu-toolchain
	git -C riscv-gnu-toolchain submodule init binutils gcc gdb glibc newlib
	sed -i s^https://sourceware.org/git/binutils-gdb.git^https://github.com/bminor/binutils-gdb^ .git/modules/riscv-gnu-toolchain/config
	sed -i s^https://gcc.gnu.org/git/gcc.git^https://github.com/gcc-mirror/gcc.git^ .git/modules/riscv-gnu-toolchain/config
	sed -i s^https://sourceware.org/git/glibc.git^https://github.com/bminor/glibc.git^ .git/modules/riscv-gnu-toolchain/config
	sed -i s^https://sourceware.org/git/newlib-cygwin.git^https://github.com/bminor/newlib.git^ .git/modules/riscv-gnu-toolchain/config
	git -C riscv-gnu-toolchain submodule update --progress --recursive --depth=1 -j 7
