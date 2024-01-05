docker buildx build --build-arg ARCH0=x64 --build-arg TAG=0 --platform=linux/amd64 --progress=plain --output type=local,dest=build/x64 .
