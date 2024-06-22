# ---- Base ----
FROM debian:stable-slim AS base
WORKDIR /app


# ---- Build ----
FROM rust:1.79.0-slim AS build
WORKDIR /build
# Copy sources
ADD .build/repository/ .
# Compile
RUN cargo build --release


# ---- Release ----
FROM base AS release
# Copy build-target
COPY --from=build /build/target/release/bandwhich .

ENTRYPOINT ["./bandwhich"]
