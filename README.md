DockerBUILDs
===

Collection of Dockerfiles created to build & pack various tools.

<br>

<!-- TOC -->
- [1. How to use](#1-how-to-use)
    - [1.1. CLI](#11-cli)
- [2. Tools](#2-tools)
    - [2.1. Bandwhich](#21-bandwhich)
    - [2.2. auto-editor](#22-auto-editor)
<!-- /TOC -->

<br>

# 1. How to use

Run the build-script `script/build.sh` with the path to the tool you want to build.

<br>

The docker-image will be tagged with `default` and the detected version/commit-hash.

You can add more tags or change the existing tag-naming-scheme using the environment-variable `TAG`.

<br>

## 1.1. CLI

`script/build.sh <toolPath> [extra-args for docker build ..]`

<br>

### 1.1.1. Environment-Variables

Variable    | Description                       | Default
-|-|-
`TAG`       | Tag for Docker-building           | `TAGPREFIX` + `NAME`
`TAGPREFIX` | Set a prefix to the default-tag   | -
`NAME`      | Change the name used in the tag   | *FolderName*

<br>

# 2. Tools

## 2.1. Bandwhich

### 2.1.1. Source
>This is a CLI utility for displaying current network utilization by process, connection and remote IP/hostname

https://github.com/imsnif/bandwhich

<br>

### 2.1.2. Example
```
docker run -it --net host bandwhich -i eth0
```

<br>

## 2.2. auto-editor

### 2.2.1. Source
>Auto-Editor is a command line application for automatically editing video and audio by analyzing a variety of methods, most notably audio loudness.

https://github.com/WyattBlue/auto-editor

<br>

### 2.2.2. Example
Speed-up silent part of videos:
```
docker run -v /home/ruakij/Videos:/video auto-build --no-open --silent-speed 8 --margin 0.2sec "input.webm" -o edited.mp4
```

<br>

### 2.2.3. Comment
TODO: Unfortunately the tool requires ffmpeg which is a huge tool and blows up the size of the image. I have to find a way to use a minimized version of it.
