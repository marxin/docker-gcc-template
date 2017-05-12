FROM opensuse:tumbleweed

RUN zypper --non-interactive --gpg-auto-import-keys install git wget unzip flex make zip gcc-c++ gcc gcc-32bit gmp-devel mpfr-devel mpc-devel tar bison which  patch

ENV SHELL /bin/bash
WORKDIR /build

RUN wget -q https://github.com/gcc-mirror/gcc/archive/a4853e4c5f6d4e539c250b4b1be226fa92dd2bab.tar.gz
RUN tar xvzf a4853e4c5f6d4e539c250b4b1be226fa92dd2bab.tar.gz
WORKDIR gcc-a4853e4c5f6d4e539c250b4b1be226fa92dd2bab

RUN mkdir objdir 
WORKDIR objdir
RUN ../configure --enable-languages=c,c++,go,lto --enable-checking=assert --disable-multilib --disable-bootstrap --disable-libsanitizer --prefix=/build/bin/gcc &&  make -j$(nproc) && make install

ENV PATH /build/bin/gcc/bin:$PATH
ENV LD_LIBRARY_PATH /build/bin/gcc/bin:$LD_LIBRARY_PATH

WORKDIR /build/test
RUN gcc -v
