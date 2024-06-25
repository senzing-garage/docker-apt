# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
[markdownlint](https://dlaa.me/markdownlint/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.15] - 2024-06-24

### Changed in 1.0.15

- In `Dockerfile`, updated FROM instruction to `debian:11.9-slim@sha256:acc5810124f0929ab44fc7913c0ad936b074cbd3eadf094ac120190862ba36c4`

## [1.0.14] - 2024-05-22

### Changed in 1.0.14

- In `Dockerfile`, 
  - updated FROM instruction to `debian:11.9-slim@sha256:0e75382930ceb533e2f438071307708e79dc86d9b8e433cc6dd1a96872f2651d`
  - updated `senzingrepo_2.0.0-1_all.deb`

## [1.0.13] - 2023-09-29

### Changed in 1.0.13

- In `Dockerfile`, updated FROM instruction to `debian:11.7-slim@sha256:c618be84fc82aa8ba203abbb07218410b0f5b3c7cb6b4e7248fda7785d4f9946`

## [1.0.12] - 2023-05-11

### Changed in 1.0.12

- In `Dockerfile`, updated FROM instruction to `debian:11.7-slim@sha256:f4da3f9b18fc242b739807a0fb3e77747f644f2fb3f67f4403fafce2286b431a`

## [1.0.11] - 2023-04-04

### Changed in 1.0.1

- In `Dockerfile`, updated FROM instruction to `debian:11.6-slim@sha256:7acda01e55b086181a6fa596941503648e423091ca563258e2c1657d140355b1`

## [1.0.10] - 2022-09-29

### Changed in 1.0.10

- In `Dockerfile`, updated FROM instruction to `debian:11.5-slim@sha256:5cf1d98cd0805951484f33b34c1ab25aac7007bb41c8b9901d97e4be3cf3ab04`

## [1.0.9] - 2022-06-08

### Changed in 1.0.9

- Upgrade `Dockerfile` to `FROM debian:11.3-slim@sha256:06a93cbdd49a265795ef7b24fe374fee670148a7973190fb798e43b3cf7c5d0f`

## [1.0.8] - 2021-04-21

### Changed in 1.0.8

- Updated entrypoint

## [1.0.7] - 2022-04-07

### Changed in 1.0.7

- Make `SENZING_APT_REPOSITORY_URL` a docker build arg.

## [1.0.6] - 2021-10-11

### Changed in 1.0.6

- Updated Debian version 10.10

## [1.0.5] - 2021-09-10

### Changed in 1.0.5

- Update base to debian:10.10
- Refresh apt metadata

## [1.0.4] - 2020-07-31

### Changed in 1.0.4

- Add `DEBIAN_FRONTEND` environment variable.

## [1.0.3] - 2020-01-29

### Changed in 1.0.3

- Upgrade Dockerfile to `FROM debian:10.2`

## [1.0.2] - 2020-01-27

### Changed in 1.0.2

- Upgrade Dockerfile to `FROM debian:10`

### Deleted in 1.0.2

- Specific mention of `senzingdata-v1` is deleted.
  It is automatically installed via `senzingapi` dependency.

## [1.0.0] - 2019-11-13

### Added to 1.0.0

- Support for msodbcsql17
- Support for senzing packages
