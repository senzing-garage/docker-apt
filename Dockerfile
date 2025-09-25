ARG BASE_IMAGE=debian:13-slim@sha256:c2880112cc5c61e1200c26f106e4123627b49726375eb5846313da9cca117337
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2025-09-02
ARG SENZING_APT_REPOSITORY_URL=https://senzing-production-apt.s3.amazonaws.com/senzingrepo_2.0.1-1_all.deb

LABEL Name="senzing/apt" \
      Maintainer="support@senzing.com" \
      Version="1.0.17"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Install packages via apt-get.

RUN apt-get update \
 && apt-get -y install \
    apt-transport-https \
      ca-certificates \
      curl \
      gnupg \
      wget

# Install Senzing repository index.

RUN curl \
      --output /senzingrepo_2.0.0-1_all.deb \
      ${SENZING_APT_REPOSITORY_URL} \
 && apt-get -y install \
      /senzingrepo_2.0.0-1_all.deb \
 && apt-get update \
 && rm /senzingrepo_2.0.0-1_all.deb

# Support for msodbcsql17.

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
 && curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list \
 && apt-get update

# Copy files from repository.

COPY ./rootfs /

USER 1001

## Set environment

ENV DEBIAN_FRONTEND=noninteractive

# Runtime execution.

ENTRYPOINT ["/app/docker-entrypoint.sh"]
