# docker-apt

If you are beginning your journey with [Senzing],
please start with [Senzing Quick Start guides].

You are in the [Senzing Garage] where projects are "tinkered" on.
Although this GitHub repository may help you understand an approach to using Senzing,
it's not considered to be "production ready" and is not considered to be part of the Senzing product.
Heck, it may not even be appropriate for your application of Senzing!

## Synopsis

A Docker wrapper over the `apt` command.

## Overview

This repository creates a Docker wrapper over the `apt` command.
It can be used to download and extract "deb" files.
The default behavior is to install the latest `senzingapi` packages.

### Contents

1. [Preamble]
   1. [Legend]
1. [Related artifacts]
1. [Expectations]
1. [Demonstrate using Docker]
   1. [EULA]
   1. [Docker volumes]
   1. [Run Docker container]
1. [Develop]
   1. [Prerequisites for development]
   1. [Clone repository]
   1. [Build Docker image]
1. [Examples]
   1. [Examples of Docker]
1. [Advanced]
   1. [Configuration]
1. [Errors]
1. [References]

## Preamble

At [Senzing], we strive to create GitHub documentation in a
"[don't make me think]" style. For the most part, instructions are copy and paste.
Whenever thinking is needed, it's marked with a "thinking" icon :thinking:.
Whenever customization is needed, it's marked with a "pencil" icon :pencil2:.
If the instructions are not clear, please let us know by opening a new
[Documentation issue] describing where we can improve. Now on with the show...

### Legend

1. :thinking: - A "thinker" icon means that a little extra thinking may be required.
   Perhaps there are some choices to be made.
   Perhaps it's an optional step.
1. :pencil2: - A "pencil" icon means that the instructions may need modification before performing.
1. :warning: - A "warning" icon means that something tricky is happening, so pay attention.

## Related artifacts

1. [DockerHub]
1. [Helm Chart]

## Expectations

- **Space:** This repository and demonstration require 6 GB free disk space.
- **Time:** Budget 10 minutes to get the demonstration up-and-running, depending on CPU and network speeds.
- **Background knowledge:** This repository assumes a working knowledge of:
  - [Docker]

## Demonstrate using Docker

### EULA

To use the Senzing code, you must agree to the End User License Agreement (EULA).

1. :warning: This step is intentionally tricky and not simply copy/paste.
   This ensures that you make a conscious effort to accept the EULA.
   Example:

    <pre>export SENZING_ACCEPT_EULA="&lt;the value from <a href="https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_accept_eula">this link</a>&gt;"</pre>

### Docker volumes

Senzing follows the [Linux File Hierarchy Standard].
Environment variables will be used in `--volume` options to externalize the installations.

1. :pencil2: Specify the directory where to install Senzing.
   Example:

   ```console
   export SENZING_VOLUME=~/my-senzing
   ```

   1. :warning:
      **macOS** - [File sharing MacOS]
      must be enabled for `SENZING_VOLUME`.
   1. :warning:
      **Windows** - [File sharing Windows]
      must be enabled for `SENZING_VOLUME`.

### Run Docker container

1. Run Docker container.
   Example:

   ```console
   docker run \
     --env SENZING_ACCEPT_EULA=${SENZING_ACCEPT_EULA} \
     --rm \
     --volume ${SENZING_VOLUME}:/opt/senzing \
     senzing/apt
   ```

1. When complete, Senzing is installed in the `SENZING_VOLUME` directory.
1. For more examples of use, see [Examples of Docker].

## Develop

The following instructions are used when modifying and building the Docker image.

### Prerequisites for development

:thinking: The following tasks need to be complete before proceeding.
These are "one-time tasks" which may already have been completed.

1. The following software programs need to be installed:
   1. [git]
   1. [make]
   1. [Docker]

### Clone repository

For more information on environment variables,
see [Environment Variables].

1. Set these environment variable values:

   ```console
   export GIT_ACCOUNT=senzing
   export GIT_REPOSITORY=docker-apt
   export GIT_ACCOUNT_DIR=~/${GIT_ACCOUNT}.git
   export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/${GIT_REPOSITORY}"
   ```

1. Using the environment variables values just set, follow steps in [clone-repository] to install the Git repository.

### Build Docker image

1. **Option #1:** Using `docker` command and GitHub.

   ```console
   sudo docker build \
     --tag senzing/apt \
     https://github.com/senzing-garage/docker-apt.git#main
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

   Note: `sudo make docker-build-development-cache` can be used to create cached Docker layers.

## Examples

### Examples of Docker

The following examples require initialization described in
[Demonstrate using Docker].

#### Manually accept EULA

By not setting `SENZING_ACCEPT_EULA_PARAMETER`, the containerized `yum` install will prompt for manual EULA acceptance.

1. Run Docker container.
   Example:

   ```console
   sudo docker run \
     --interactive \
     --rm \
     --tty \
     --volume ${SENZING_VOLUME}:/opt/senzing \
     senzing/apt
   ```

#### Install local DEB files

`senzing/apt` can be used to install local DEB files.

1. To download Senzing DEB file, see
   [github.com/Senzing/docker-aptdownloader].

1. :pencil2: Set additional environment variables.
   Identify directory containing DEB files and the exact names of the DEB files.
   Example:

   ```console
   export SENZING_DEB_DIR=~/Downloads
   export SENZING_API_DEB_FILENAME=senzingapi-nn.nn.nn.x86_64.rpm
   export SENZING_DATA_DEB_FILENAME=senzingdata-v1-nn.nn.nn.x86_64.rpm
   ```

1. Run the Docker container.
   Example:

   ```console
   sudo docker run \
     --env SENZING_ACCEPT_EULA=${SENZING_ACCEPT_EULA} \
     --rm \
     --volume ${SENZING_VOLUME}:/opt/senzing \
     --volume ${SENZING_DEB_DIR}:/data \
     senzing/apt -y localinstall \
       /data/${SENZING_DATA_DEB_FILENAME} \
       /data/${SENZING_API_DEB_FILENAME}
   ```

## Advanced

### Configuration

Configuration values specified by environment variable or command line parameter.

- **[SENZING_ACCEPT_EULA]**
- **[SENZING_API_DEB_FILENAME]**
- **[SENZING_DATA_DIR]**
- **[SENZING_DATA_DEB_FILENAME]**
- **[SENZING_DEB_DIR]**
- **[SENZING_G2_DIR]**

## Errors

1. See [docs/errors.md].

## References

[Advanced]: #advanced
[Build Docker image]: #build-docker-image
[Clone repository]: #clone-repository
[clone-repository]: https://github.com/senzing-garage/knowledge-base/blob/main/HOWTO/clone-repository.md
[Configuration]: #configuration
[Demonstrate using Docker]: #demonstrate-using-docker
[Develop]: #develop
[Docker volumes]: #docker-volumes
[Docker]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/docker.md
[DockerHub]: https://hub.docker.com/r/senzing/apt
[docs/errors.md]: docs/errors.md
[Documentation issue]: https://github.com/senzing-garage/docker-apt/issues/new?template=documentation_request.md
[don't make me think]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/dont-make-me-think.md
[Environment Variables]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md
[Errors]: #errors
[EULA]: #eula
[Examples of Docker]: #examples-of-docker
[Examples]: #examples
[Expectations]: #expectations
[File sharing MacOS]: https://github.com/senzing-garage/knowledge-base/blob/main/HOWTO/share-directories-with-docker.md#macos
[File sharing Windows]: https://github.com/senzing-garage/knowledge-base/blob/main/HOWTO/share-directories-with-docker.md#windows
[git]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/git.md
[github.com/Senzing/docker-aptdownloader]: https://github.com/senzing-garage/docker-aptdownloader
[Helm Chart]: https://github.com/senzing-garage/charts/tree/main/charts/senzing-apt
[Legend]: #legend
[Linux File Hierarchy Standard]: https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf
[make]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/make.md
[Preamble]: #preamble
[Prerequisites for development]: #prerequisites-for-development
[References]: #references
[Related artifacts]: #related-artifacts
[Run Docker container]: #run-docker-container
[Senzing Garage]: https://github.com/senzing-garage
[Senzing Quick Start guides]: https://docs.senzing.com/quickstart/
[SENZING_ACCEPT_EULA]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_accept_eula
[SENZING_API_DEB_FILENAME]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_api_deb_filename
[SENZING_DATA_DEB_FILENAME]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_data_deb_filename
[SENZING_DATA_DIR]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_data_dir
[SENZING_DEB_DIR]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_deb_dir
[SENZING_G2_DIR]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_g2_dir
[Senzing]: https://senzing.com/
