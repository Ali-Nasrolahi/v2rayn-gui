FROM ubuntu:26.10

ARG V2RAYN_VERSION=7.23.3

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates && \
    curl -fL \
    "https://github.com/2dust/v2rayN/releases/download/${V2RAYN_VERSION}/v2rayN-linux-64.deb" \
    -o /tmp/v2rayN-linux-64.deb && \
    apt-get install -y --no-install-recommends \
    /tmp/v2rayN-linux-64.deb \
    libicu78 \
    libsm6 \
    libice6 \
    libx11-6 \
    fonts-noto-color-emoji \
    tzdata && \
    chmod -R go=u /opt/v2rayN && \
    apt-get purge -y --auto-remove curl && \
    apt-get clean && \
    rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /usr/share/doc/* \
    /usr/share/man/*

CMD ["/bin/v2rayn"]
