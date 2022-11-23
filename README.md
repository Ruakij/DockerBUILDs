DockerBUILDs
===

Collection of Dockerfiles created to build & pack various tools.

<br>

<!-- TOC -->
- [1. Tools](#1-tools)
    - [1.1. Bandwhich](#11-bandwhich)
<!-- /TOC -->

<br>

# 1. Tools

## 1.1. Bandwhich

### 1.1.1. Source
>This is a CLI utility for displaying current network utilization by process, connection and remote IP/hostname

https://github.com/imsnif/bandwhich

<br>

### 1.1.2. Example
```
docker run --net host bandwhich -i eth0
```
