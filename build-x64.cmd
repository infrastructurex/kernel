docker buildx build --build-arg CONFIG_FILE=kernel-x64.config --build-arg TAG=0 --platform=linux/amd64 --progress=plain --output type=local,dest=build/x64 .
copy /Y build\x64\kernel.tar.gz ..\nanoos
