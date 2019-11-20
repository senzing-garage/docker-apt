# docker-apt

## Overview

This repository is a wrapper over the `apt` command.
It can be used to download and extract "deb" files.

A running docker container installs the latest
`senzingapi` and `senzingdata-v1`
packages by running the following command:

```console
apt -y install senzingdata-v1 senzingapi
```

### Related artifacts

1. [DockerHub](https://hub.docker.com/r/senzing/apt)
1. [Helm Chart](https://github.com/Senzing/charts/tree/master/charts/senzing-apt)

### Contents

1. [Expectations](#expectations)
    1. [Space](#space)
    1. [Time](#time)
    1. [Background knowledge](#background-knowledge)
1. [Demonstrate using Docker](#demonstrate-using-docker)
    1. [Configuration](#configuration)
    1. [EULA](#eula)
    1. [Volumes](#volumes)
    1. [Run docker container](#run-docker-container)
1. [Develop](#develop)
    1. [Prerequisite software](#prerequisite-software)
    1. [Clone repository](#clone-repository)
    1. [Build docker image for development](#build-docker-image-for-development)
1. [Examples](#examples)
1. [Errors](#errors)
1. [References](#references)

### Legend

1. :thinking: - A "thinker" icon means that a little extra thinking may be required.
   Perhaps you'll need to make some choices.
   Perhaps it's an optional step.
1. :pencil2: - A "pencil" icon means that the instructions may need modification before performing.
1. :warning: - A "warning" icon means that something tricky is happening, so pay attention.

## Expectations

### Space

This repository and demonstration require 6 GB free disk space.

### Time

Budget 10 minutes to get the demonstration up-and-running, depending on CPU and network speeds.

### Background knowledge

This repository assumes a working knowledge of:

1. [Docker](https://github.com/Senzing/knowledge-base/blob/master/WHATIS/docker.md)

## Demonstrate using Docker

### Configuration

Configuration values specified by environment variable or command line parameter.

- **[SENZING_ACCEPT_EULA](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_accept_eula)**
- **[SENZING_API_DEB_FILENAME](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_api_deb_filename)**
- **[SENZING_DATA_DIR](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_data_dir)**
- **[SENZING_DATA_DEB_FILENAME](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_data_deb_filename)**
- **[SENZING_DEB_DIR](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_deb_dir)**
- **[SENZING_ETC_DIR](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_etc_dir)**
- **[SENZING_G2_DIR](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_g2_dir)**
- **[SENZING_VAR_DIR](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_var_dir)**

### EULA

To use the Senzing code, you must agree to the End User License Agreement (EULA).

1. :warning: This step is intentionally tricky and not simply copy/paste.
   This ensures that you make a conscious effort to accept the EULA.
   See [Configuration](#configuration) or
   [SENZING_ACCEPT_EULA](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_accept_eula)
   for the correct value.
   Replace the double-quote character in the example with the correct value.
   The use of the double-quote character is intentional to prevent simple copy/paste.
   Example:

    ```console
    export SENZING_ACCEPT_EULA="
    ```

1. Construct parameter for `docker run`.
   Example:

    ```console
    export SENZING_ACCEPT_EULA_PARAMETER="--env SENZING_ACCEPT_EULA=${SENZING_ACCEPT_EULA}"
    ```

### Volumes

:thinking:
The output of `apt install senzingapi` will place files in different directories.
Create a folder for each output directory.

1. **Example #1:**
   To mimic an actual DEB installation,
   identify directories for DEB output in this manner:

    ```console
    export SENZING_DATA_DIR=/opt/senzing/data
    export SENZING_G2_DIR=/opt/senzing/g2
    export SENZING_ETC_DIR=/etc/opt/senzing
    export SENZING_VAR_DIR=/var/opt/senzing
    ```

1. :pencil2: **Example #2:**
   Alternatively, directories for DEB output can be put anywhere.
   Example:

    ```console
    export SENZING_VOLUME=/opt/my-senzing

    export SENZING_DATA_DIR=${SENZING_VOLUME}/data
    export SENZING_G2_DIR=${SENZING_VOLUME}/g2
    export SENZING_ETC_DIR=${SENZING_VOLUME}/etc
    export SENZING_VAR_DIR=${SENZING_VOLUME}/var
    ```

### Run docker container

:thinking:
Just like `apt`, the `senzing/apt` container can install from a local file or from an apt repository.

**Option #1:** `apt` install from apt repository.

1. Run the docker container.
   Example:

    ```console
    sudo docker run \
      ${SENZING_ACCEPT_EULA_PARAMETER} \
      --interactive \
      --rm \
      --tty \
      --volume ${SENZING_DATA_DIR}:/opt/senzing/data \
      --volume ${SENZING_G2_DIR}:/opt/senzing/g2 \
      --volume ${SENZING_ETC_DIR}:/etc/opt/senzing \
      --volume ${SENZING_VAR_DIR}:/var/opt/senzing \
      senzing/apt
    ```

**Option #2:** `apt` install local DEB files.

1. To download Senzing DEB file, see
   [github.com/Senzing/docker-aptdownloader](https://github.com/Senzing/docker-aptdownloader).

1. :pencil2: Set environment variables.
   Identify directory containing DEB files
   and the exact name of the DEB files.
   Example:

    ```console
    export SENZING_DEB_DIR=~/Downloads
    export SENZING_API_DEB_FILENAME=senzingapi-nn.nn.nn.x86_64.rpm
    export SENZING_DATA_DEB_FILENAME=senzingdata-v1-nn.nn.nn.x86_64.rpm
    ```

1. Run docker container.
   Example:

    ```console
    sudo docker run \
      --interactive \
      --rm \
      --tty \
      --volume ${SENZING_DATA_DIR}:/opt/senzing/data \
      --volume ${SENZING_ETC_DIR}:/etc/opt/senzing \
      --volume ${SENZING_G2_DIR}:/opt/senzing/g2 \
      --volume ${SENZING_VAR_DIR}:/var/opt/senzing \
      --volume ${SENZING_DEB_DIR}:/data \
      ${SENZING_ACCEPT_EULA_PARAMETER} \
      senzing/apt -y localinstall \
        /data/${SENZING_DATA_DEB_FILENAME} \
        /data/${SENZING_API_DEB_FILENAME}
    ```

## Develop

### Prerequisite software

The following software programs need to be installed:

1. [git](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/install-git.md)
1. [make](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/install-make.md)
1. [docker](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/install-docker.md)

### Clone repository

For more information on environment variables,
see [Environment Variables](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md).

1. Set these environment variable values:

    ```console
    export GIT_ACCOUNT=senzing
    export GIT_REPOSITORY=docker-apt
    export GIT_ACCOUNT_DIR=~/${GIT_ACCOUNT}.git
    export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/${GIT_REPOSITORY}"
    ```

1. Follow steps in [clone-repository](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/clone-repository.md) to install the Git repository.

### Build docker image for development

1. **Option #1:** Using `docker` command and GitHub.

    ```console
    sudo docker build --tag senzing/apt https://github.com/senzing/docker-apt.git
    ```

1. **Option #2:** Using `docker` command and local repository.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo docker build --tag senzing/apt .
    ```

1. **Option #3:** Using `make` command.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo make docker-build
    ```

    Note: `sudo make docker-build-development-cache` can be used to create cached docker layers.

## Examples

## Errors

1. See [docs/errors.md](docs/errors.md).

## References
