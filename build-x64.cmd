docker buildx build --build-arg CONFIG_FILE=minimal-x64.config --platform=linux/amd64 --output type=local,dest=build/x64 .
copy /Y build\x64\kernel.tar.gz ..\nanoos