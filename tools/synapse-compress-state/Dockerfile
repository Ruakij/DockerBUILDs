# ---- Base ----
FROM alpine AS base
WORKDIR /app
# Install dependencies
RUN apk add --no-cache libgcc libssl1.1 libc6-compat

# ---- Build ----
FROM rust:alpine3.16 AS build
WORKDIR /build
# Install packages
RUN apk add python3 musl-dev pkgconfig openssl-dev make
# Set build-flags
ENV RUSTFLAGS="-C target-feature=-crt-static"
# Copy sources
ADD .build/repository/ .
# Update dependencies and Compile
RUN cargo update && cargo build --release


# ---- Release ----
FROM base AS release
# Copy build-target
COPY --from=build /build/target/release/synapse_compress_state .
COPY --from=build /build/target/release/synapse_auto_compressor .

ENTRYPOINT ["./synapse_compress_state"]
