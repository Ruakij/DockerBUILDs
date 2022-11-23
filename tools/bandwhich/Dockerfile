# ---- Base ----
FROM alpine:3 AS base
WORKDIR /app


# ---- Build ----
FROM rust:alpine AS build
WORKDIR /build
# Install packages
RUN apk add --no-cache make libc-dev build-base
# Copy sources
ADD .build/repository/ .
# Update dependencies
RUN cargo update
# Compile
RUN TARGET="release" make


# ---- Release ----
FROM base AS release
# Copy build-target
COPY --from=build /build/target/release/bandwhich .

CMD ["./bandwhich"]
