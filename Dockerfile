ARG BASE_IMAGE=debian:11.9-slim@sha256:0e75382930ceb533e2f438071307708e79dc86d9b8e433cc6dd1a96872f2651d
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2024-05-22
ARG SENZING_APT_REPOSITORY_URL=https://senzing-production-apt.s3.amazonaws.com/senzingrepo_2.0.0-1_all.deb

LABEL Name="senzing/apt" \
  Maintainer="support@senzing.com" \
  Version="1.0.14"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Install packages via apt.

RUN apt update \
  && apt -y install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  sudo \
  wget

# Install Senzing repository index.

RUN curl \
  --output /senzingrepo_2.0.0-1_all.deb \
  ${SENZING_APT_REPOSITORY_URL} \
  && apt -y install \
  /senzingrepo_2.0.0-1_all.deb \
  && apt update \
  && rm /senzingrepo_2.0.0-1_all.deb

# Support for msodbcsql17.

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
  && curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list \
  && apt-get update

# Copy files from repository.

COPY ./rootfs /

## Set environment

ENV DEBIAN_FRONTEND noninteractive

# Runtime execution.

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["-y", "install", "senzingapi"]
