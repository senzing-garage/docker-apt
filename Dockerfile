ARG BASE_IMAGE=debian:13-slim@sha256:a347fd7510ee31a84387619a492ad6c8eb0af2f2682b916ff3e643eb076f925a
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2025-09-25
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
