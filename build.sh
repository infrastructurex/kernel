#!/usr/bin/env sh

CONFIG=/build/.config
VERSION=$(grep '# Linux/' $CONFIG | cut -d ' ' -f 3)
VERSION_MAJOR=$(echo "$VERSION" | cut -b 1 )
SOURCE=https://cdn.kernel.org/pub/linux/kernel/v"$VERSION_MAJOR".x/linux-"$VERSION".tar.xz

echo Downloading kernel "$VERSION" ...
cd /build || exit
wget "$SOURCE"
echo Extracting kernel "$VERSION" ...
tar -xJf linux-"$VERSION".tar.xz
mv linux-"$VERSION" linux
cp .config linux/.config


echo Building kernel ...
cd /build/linux || exit
make -j"$(nproc)" || exit

if [ -f arch/arm64/boot/Image.gz ]; then
  cp arch/arm64/boot/Image.gz bzImage
fi

mkdir /export
find /build/linux -name bzImage -exec cp "{}" /export  \;

if grep -q 'CONFIG_MODULES=y' $CONFIG; then
  INSTALL_MOD_PATH=/export make modules_install
  rm -Rf /export/lib/modules/*/build
  rm -Rf /export/lib/modules/*/source
fi


echo Packaging kernel ...
cd /export || exit
mv bzImage kernel
cp /build/LICENSE .
echo "Source  : $SOURCE" > /export/SOURCE
echo "Version : $VERSION" >> /export/SOURCE
echo "Package : https://github.com/vmify/kernel/releases/download/$TAG/kernel-$ARCH0-$TAG.tar.gz" >> /export/SOURCE
tar -czvf /kernel.tar.gz *
