FROM ubuntu:18.04

RUN apt-get update && apt-get install \
    curl \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "curl" ]