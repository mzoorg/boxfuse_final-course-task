FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y \
    git \
    maven \
    default-jdk
WORKDIR /data
RUN git clone https://github.com/mzoorg/boxfuse-orig.git
WORKDIR /data/boxfuse-orig
RUN mvn package