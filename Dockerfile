ARG BASE_IMAGE=debian:13-slim@sha256:26f98ccd92fd0a44d6928ce8ff8f4921b4d2f535bfa07555ee5d18f61429cf0c
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2026-01-05
ARG SENZING_APT_REPOSITORY_URL=https://senzing-production-apt.s3.amazonaws.com/senzingrepo_2.0.1-1_all.deb

LABEL Name="senzing/apt" \
      Maintainer="support@senzing.com" \
      Version="1.0.17"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Install packages via apt-get.

RUN apt-get update \
 && apt-get -y --no-install-recommends install \
      apt-transport-https \
      ca-certificates \
      curl

# Install Senzing repository index.

RUN curl --output /senzingrepo.deb  ${SENZING_APT_REPOSITORY_URL} \
 && apt-get -y --no-install-recommends install /senzingrepo.deb \
 && apt-get update \
 && rm /senzingrepo.deb

# Support for msodbcsql17.

RUN curl -sSL -O https://packages.microsoft.com/config/debian/$(grep VERSION_ID /etc/os-release | cut -d '"' -f 2 | cut -d '.' -f 1)/packages-microsoft-prod.deb \
 && apt-get -y --no-install-recommends install /packages-microsoft-prod.deb \
 && apt-get update \
 && rm /packages-microsoft-prod.deb

# Copy files from repository.

COPY ./rootfs /

USER 1001

## Set environment

ENV DEBIAN_FRONTEND=noninteractive

# Runtime execution.

ENTRYPOINT ["/app/docker-entrypoint.sh"]
