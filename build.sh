#!/usr/bin/env sh

CONFIG=/build/.config
VERSION=$(grep '# Linux/' $CONFIG | cut -d ' ' -f 3)
VERSION_MAJOR=$(echo "$VERSION" | cut -b 1 )


echo Downloading kernel "$VERSION" ...
cd /build || exit
wget https://cdn.kernel.org/pub/linux/kernel/v"$VERSION_MAJOR".x/linux-"$VERSION".tar.xz
echo Extracting kernel "$VERSION" ...
tar -xJf linux-"$VERSION".tar.xz
mv linux-"$VERSION" linux
cp .config linux/.config


echo Building kernel ...
cd /build/linux || exit

make -j"$(nproc)" || exit
mkdir /export
find /build/linux -name bzImage -exec cp "{}" /export  \;

if grep -q 'CONFIG_MODULES=y' $CONFIG; then
  INSTALL_MOD_PATH=/export make modules_install
  rm -Rf /export/lib/modules/*/build
  rm -Rf /export/lib/modules/*/source
fi


echo Packaging kernel ...
cd /export || exit
cp /build/LICENSE .
tar -czvf /kernel.tar.gz *