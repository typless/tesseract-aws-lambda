# docker_build tesseract

cd ~
git clone https://github.com/DanBloomberg/leptonica.git
cd leptonica/
git checkout $LEPTONICA_VERSION # newer version crashes tesseract build for now. See https://github.com/tesseract-ocr/tesseract/issues/3815
./autogen.sh
./configure
make
make install

# tesseract
cd ~
git clone https://github.com/tesseract-ocr/tesseract.git
cd tesseract
git checkout $TESSERACT_VERSION
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
./autogen.sh
./configure
make
make install

cd ~
mkdir tesseract-standalone
# copy files
cd tesseract-standalone

mkdir bin
cp /usr/local/bin/tesseract ./bin

mkdir lib
cp /usr/local/lib/libtesseract.so.5 lib/
cp /lib64/libpng15.so.15 lib/
cp /lib64/libtiff.so.5 lib/
cp /lib64/libgomp.so.1 lib/
cp /lib64/libjbig.so.2.0 lib/
cp /usr/local/lib/libleptonica.so.6 lib/
cp /usr/lib64/libjpeg.so.62 lib/
cp /usr/lib64/libwebp.so.4 lib/
cp /usr/lib64/libstdc++.so.6 lib/

# copy training data
mkdir tessdata
cd tessdata

wget https://github.com/tesseract-ocr/tessdata/blob/main/eng.traineddata

# archive
cd ~
cd tesseract-standalone
mkdir python

cd ~
# trim unneeded ~ 15 MB
strip ./tesseract-standalone/**/*

cd tesseract-standalone

zip -r9 ../tesseract.zip *