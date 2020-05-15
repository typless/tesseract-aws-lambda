FROM amazonlinux:2018.03.0.20200318.1

ENV LEPTONICA_VERSION="1.75.1"
# docker_build leptonica
WORKDIR /tmp/
RUN yum install clang wget zip gzip tar autoconf xz libpng-devel libtiff-devel zlib-devel libwebp-devel libjpeg-turbo-devel make libtool pkgconfig -y
RUN wget https://github.com/DanBloomberg/leptonica/releases/download/$LEPTONICA_VERSION/leptonica-$LEPTONICA_VERSION.tar.gz
RUN tar -xzvf leptonica-$LEPTONICA_VERSION.tar.gz
RUN cd leptonica-$LEPTONICA_VERSION && ./configure && make && make install

RUN wget http://ftpmirror.gnu.org/autoconf-archive/autoconf-archive-2019.01.06.tar.xz
RUN tar -xvf autoconf-archive-2019.01.06.tar.xz
RUN cd autoconf-archive-2019.01.06 && ./configure && make && make install
RUN cd autoconf-archive-2019.01.06 && cp m4/* /usr/share/aclocal/

COPY build_tesseract.sh /tmp/build_tesseract.sh
RUN chmod +x /tmp/build_tesseract.sh
CMD sh /tmp/build_tesseract.sh