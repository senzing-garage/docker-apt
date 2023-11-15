ARG BASE_IMAGE=debian:11.8-slim@sha256:19664a5752dddba7f59bb460410a0e1887af346e21877fa7cec78bfd3cb77da5
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2023-11-14
ARG SENZING_APT_REPOSITORY_URL=https://senzing-production-apt.s3.amazonaws.com/senzingrepo_1.0.0-1_amd64.deb

LABEL Name="senzing/apt" \
      Maintainer="support@senzing.com" \
      Version="1.0.10"

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
    --output /senzingrepo_1.0.0-1_amd64.deb \
    ${SENZING_APT_REPOSITORY_URL} \
 && apt -y install \
    /senzingrepo_1.0.0-1_amd64.deb \
 && apt update \
 && rm /senzingrepo_1.0.0-1_amd64.deb

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
