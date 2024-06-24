ARG BASE_IMAGE=debian:11.9-slim@sha256:acc5810124f0929ab44fc7913c0ad936b074cbd3eadf094ac120190862ba36c4
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2024-06-24
ARG SENZING_APT_REPOSITORY_URL=https://senzing-production-apt.s3.amazonaws.com/senzingrepo_2.0.0-1_all.deb

LABEL Name="senzing/apt" \
  Maintainer="support@senzing.com" \
  Version="1.0.14"

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

ENV DEBIAN_FRONTEND noninteractive

# Runtime execution.

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["-y", "install", "senzingapi"]
