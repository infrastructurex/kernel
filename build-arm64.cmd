docker buildx build --build-arg CONFIG_FILE=kernel-arm64.config --build-arg TAG=0 --platform=linux/arm64 --progress=plain --output type=local,dest=build/arm64 .
