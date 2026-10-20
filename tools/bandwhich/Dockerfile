# Upstream release binaries (static musl), verified by sha256.
# BANDWHICH_VERSION and the SHA256_* values are updated together by
# .github/workflows/bandwhich-upstream-sync.yaml.
ARG BANDWHICH_VERSION=0.23.1
ARG SHA256_AMD64=fec93e01c393cd3ef8aa168a675dffb8fa4841d5fd93390b5d14f238ae29e59c
ARG SHA256_ARM64=6bbf084e5280a1a10833b8f466728ff428a7d637282c0487d6fcda0c4781357a
ARG SHA256_ARMV7=35b8380879065816b7c5a4cdca373701aae7f73241680d10dd98320e131c6cd7

ARG TARGETARCH
ARG TARGETVARIANT


# ---- Download, one stage per architecture; only the one matching the target is built ----
FROM --platform=$BUILDPLATFORM debian:stable-slim@sha256:a717a33469731894e77e912ea7d714e27c2dc38ee6554fd1a3102e92999cfc66 AS download-base
RUN mkdir /out

FROM download-base AS download-amd64
ARG BANDWHICH_VERSION
ARG SHA256_AMD64
ADD --checksum=sha256:${SHA256_AMD64} \
    https://github.com/imsnif/bandwhich/releases/download/v${BANDWHICH_VERSION}/bandwhich-v${BANDWHICH_VERSION}-x86_64-unknown-linux-musl.tar.gz /tmp/bandwhich.tar.gz

FROM download-base AS download-arm64
ARG BANDWHICH_VERSION
ARG SHA256_ARM64
ADD --checksum=sha256:${SHA256_ARM64} \
    https://github.com/imsnif/bandwhich/releases/download/v${BANDWHICH_VERSION}/bandwhich-v${BANDWHICH_VERSION}-aarch64-unknown-linux-musl.tar.gz /tmp/bandwhich.tar.gz

FROM download-base AS download-armv7
ARG BANDWHICH_VERSION
ARG SHA256_ARMV7
ADD --checksum=sha256:${SHA256_ARMV7} \
    https://github.com/imsnif/bandwhich/releases/download/v${BANDWHICH_VERSION}/bandwhich-v${BANDWHICH_VERSION}-armv7-unknown-linux-musleabihf.tar.gz /tmp/bandwhich.tar.gz

FROM download-${TARGETARCH}${TARGETVARIANT} AS download
RUN tar -xzf /tmp/bandwhich.tar.gz -C /out bandwhich


# ---- Release ----
FROM debian:stable-slim@sha256:a717a33469731894e77e912ea7d714e27c2dc38ee6554fd1a3102e92999cfc66 AS release
ARG BANDWHICH_VERSION
LABEL org.opencontainers.image.title="bandwhich" \
      org.opencontainers.image.description="Terminal bandwidth utilization tool, packaged upstream release binary" \
      org.opencontainers.image.source="https://github.com/Ruakij/DockerBUILDs" \
      org.opencontainers.image.url="https://github.com/imsnif/bandwhich" \
      org.opencontainers.image.version="${BANDWHICH_VERSION}"
COPY --from=download --chown=0:0 /out/bandwhich /usr/local/bin/bandwhich

ENTRYPOINT ["bandwhich"]
