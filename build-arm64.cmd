docker buildx build --build-arg CONFIG_FILE=minimal-arm64.config --platform=linux/arm64 --progress=plain --output type=local,dest=build/arm64 .