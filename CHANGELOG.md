# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
[markdownlint](https://dlaa.me/markdownlint/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.7] - 2022-04-07

- Make `SENZING_APT_REPOSITORY_URL` a docker build arg.

## [1.0.6] - 2021-10-11

- Updated Debian version 10.10

### Changed in 1.0.6

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
