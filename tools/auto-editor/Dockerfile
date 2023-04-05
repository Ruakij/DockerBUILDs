# ---- Base ----
FROM python:slim AS base
#ENV PYTHONDONTWRITEBYTECODE=1
WORKDIR /app
# Install packages
RUN apt update && apt install -y ffmpeg && rm -rf /var/lib/apt/lists/*
#RUN pip install --no-compile --no-cache-dir ae-ffmpeg
#COPY .build/repository/ae-ffmpeg/ae_ffmpeg/Darwin-x86_64/* /usr/bin/

# ---- Build ----
FROM base AS build
ENV PYTHONDONTWRITEBYTECODE=1
# Copy sources
ADD .build/repository/auto_editor auto_editor
ADD .build/repository/setup.py .
ADD .build/repository/README.md .
# Run install
RUN pip install --no-compile --no-cache-dir -e .

# ---- Release ----
FROM build AS release
WORKDIR /videos

ENTRYPOINT ["auto-editor"]
