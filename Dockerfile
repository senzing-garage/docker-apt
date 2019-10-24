ARG BASE_IMAGE=debian:9
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2019-10-24

LABEL Name="senzing/apt" \
      Maintainer="support@senzing.com" \
      Version="1.0.0"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Install packages via apt.

RUN apt update \
 && apt -y install \
    apt-transport-https \
    curl \
    gnupg \
    sudo \
    wget

# Install Senzing repository index.

RUN curl \
    --output /senzingrepo_1.0.0-1_amd64.deb \
    https://senzing-production-apt.s3.amazonaws.com/senzingrepo_1.0.0-1_amd64.deb \
 && apt -y install \
    /senzingrepo_1.0.0-1_amd64.deb \
 && apt update \
 && rm /senzingrepo_1.0.0-1_amd64.deb

# Copy files from repository.

COPY ./rootfs /

# Runtime execution.

ENTRYPOINT ["apt"]
CMD ["-y", "install", "senzingdata-v1", "senzingapi"]
