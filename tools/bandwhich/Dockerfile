# ---- Base ----
FROM debian:stable-slim AS base
WORKDIR /app


# ---- Build ----
FROM rust:1.65.0-slim AS build
WORKDIR /build
# Install packages
RUN apt update && apt install -y make
# Copy sources
ADD .build/repository/ .
# Update dependencies and Compile
RUN cargo update && TARGET="release" make


# ---- Release ----
FROM base AS release
# Copy build-target
COPY --from=build /build/target/release/bandwhich .

ENTRYPOINT ["./bandwhich"]
