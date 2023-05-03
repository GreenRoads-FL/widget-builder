FROM node:14-bullseye-slim

# Common dependencies
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    curl \
    less \
    git \
    openssh-client \
    python3 \
    python2 \
    ca-certificates \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

RUN update-ca-certificates

WORKDIR /usr/src/widget-builder

COPY . .

RUN npm install
RUN npm run install-cli

WORKDIR /usr/src/widgets

ENTRYPOINT ["widget-builder"]
