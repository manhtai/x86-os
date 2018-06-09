# Ref: https://wiki.osdev.org/GCC_Cross-Compiler

# requirements
apt-get update
apt-get install -y nasm gdb gcc build-essential bison flex libgmp3-dev libmpc-dev libmpfr-dev texinfo

# prepare
export PREFIX="$HOME/opt/cross"
export TARGET=i386-elf
export PATH="$PREFIX/bin:$PATH"

export BINUTILS="binutils-2.30"
export GCC="gcc-8.1.0"

mkdir $HOME/src

# binutils
cd $HOME/src
curl -O http://ftp.gnu.org/gnu/binutils/${BINUTILS}.tar.gz
tar xf ${BINUTILS}.tar.gz

mkdir build-binutils
cd build-binutils
../${BINUTILS}/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make
make install

# gcc
cd $HOME/src
mkdir build-gcc
curl -O https://ftp.gnu.org/gnu/gcc/${GCC}/${GCC}.tar.gz
tar xf ${GCC}.tar.gz

cd build-gcc
../${GCC}/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc

# Set path
echo 'export PATH="$HOME/opt/cross/bin:$PATH"' >> ~/.bashrc
