docker buildx build --build-arg ARCH=x64 --build-arg TAG=0 --platform=linux/amd64 --progress=plain --output type=local,dest=build/x64 .
copy /Y build\x64\kernel.tar.gz ..\nanoos
