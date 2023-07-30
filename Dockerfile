FROM public.ecr.aws/lambda/python:3.10-x86_64

ENV LEPTONICA_VERSION="1.83.0"
ENV TESSERACT_VERSION="5.3.0"
WORKDIR /tmp/

RUN yum install -y aclocal autoconf automake cmakegcc freetype-devel gcc gcc-c++ \
	git lcms2-devel libjpeg-devel libjpeg-turbo-devel autogen autoconf libtool \
	libpng-devel libtiff-devel libtool libwebp-devel libzip-devel make zlib-devel zip

COPY build_tesseract.sh /tmp/build_tesseract.sh
RUN chmod +x /tmp/build_tesseract.sh
ENTRYPOINT ["sh", "/tmp/build_tesseract.sh"]