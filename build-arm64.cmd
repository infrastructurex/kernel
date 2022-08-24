docker buildx build --build-arg ARCH0=arm64 --build-arg TAG=0 --platform=linux/arm64 --progress=plain --output type=local,dest=build/arm64 .
