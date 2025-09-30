FROM alpine:3.22.1 AS build

ARG ARCH0
ENV ARCH0=$ARCH0
ARG TAG
ENV TAG=$TAG

RUN apk add wget xz alpine-sdk flex bison bc linux-headers diffutils elfutils-dev gmp-dev mpc1-dev mpfr-dev openssl-dev findutils perl zstd
ADD kernel-$ARCH0.config /build/.config
ADD kernel.license /build/LICENSE
ADD efi-cmdline.patch /build
ADD build.sh /build
RUN sh -c /build/build.sh


FROM scratch AS export
COPY --from=build /kernel.tar.gz .
