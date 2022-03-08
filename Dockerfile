FROM alpine:3.15.0 AS build

ARG CONFIG_FILE
RUN apk add wget xz alpine-sdk flex bison bc linux-headers diffutils elfutils-dev gmp-dev mpc1-dev mpfr-dev openssl1.1-compat-dev findutils perl
ADD $CONFIG_FILE /build/.config
ADD kernel.license /build/LICENSE
ADD build.sh /build
RUN sh -c /build/build.sh


FROM scratch AS export
COPY --from=build /kernel.tar.gz .