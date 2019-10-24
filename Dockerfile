ARG BASE_IMAGE=debian:9
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2019-10-24

LABEL Name="senzing/apt" \
      Maintainer="support@senzing.com" \
      Version="1.0.0"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Install packages via yum.

RUN apt -y install \
    https://senzing-production-apt.s3.amazonaws.com/senzingrepo_1.0.0-1_amd64.deb

# Copy files from repository.

COPY ./rootfs /

# Runtime execution.

ENTRYPOINT ["apt"]
CMD ["-y", "install", "senzingdata-v1", "senzingapi"]
