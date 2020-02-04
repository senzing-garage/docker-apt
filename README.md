# docker-apt
Docker-apt is a way to download the Senzing API, via the `apt` command, onto a docker container. This allows you to use the API from any operating system.

More specifically, this image will download the latest `senzingdata-v1` and `senzingapi`.

### Contents
1. [Expectations](#expectations)
    1. [Space](#space)
    1. [Time](#time)
    1. [Background knowledge](#background-knowledge)
1. [Setup and Run Container](#setup-and-run-container)
    1. [Create Project Directory and Mount Volumes](#create-project-directory-and-mount-volumes)
    1. [Configure Environment Variables](configure-environment-variables)
    1. [Accepting the EULA](#accepting-the-eula)
    1. [Run docker container](#run-docker-container)
1. [Develop with Senzing Container](#develop-with-senzing-container)
    1. [Prerequisite software](#prerequisite-software)
    1. [Clone repository](#clone-repository)
    1. [Build docker image for development](#build-docker-image-for-development)
1. [Examples](#examples)
1. [Errors](#errors)
1. [References](#references)
1. [See Also](#see-also)

# Before you install

**Space:** This repository and demonstration require 6 GB free disk space.

**Time:** Budget 10 minutes to get the demonstration up-and-running, depending on CPU and network speeds.

**Background Knowledge:**
- Working knowledge of [docker](https://github.com/Senzing/knowledge-base/blob/master/WHATIS/docker.md).

# Setting up and running the container
In order to successfully install the api through docker, a number of steps are required. These will be done through the help of environment variables, which will hold these values for us while the image installs the API onto the container.
1. [Configure Environment Variables](#configure-environment-variables)
1. [Create Project Directory and Mount Volumes](#create-project-directory-and-mount-volumes)
1. [Accepting the EULA](#accepting-the-eula)
1. [Running the Container](#running-the-senzing-container)

 
## Configure Environment Variables
The Senzing API uses a number of parameters to let you decide exactly how it should be installed, and it does so with the help of environemnt variables. 

There's a number of ways in which you could define your environment variables, in shell scripts, in `.env` files, or directly through the command line. Really the way you chose to store them is largely up to you, and we have examples on how to do it with the 3 ways mentioned above [here](/ENVIRONMENT_VARIABLES.md). In this example, we'll be using a `.env` file because it keeps all our variables easy to see, and  reduces the length of the commands. 


Here is a list of the environment variables we'll be defining. You can click on any of them to learn more.
- **[SENZING_ACCEPT_EULA](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_accept_eula)**
- **[SENZING_API_DEB_FILENAME](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_api_deb_filename)**
- **[SENZING_DATA_DIR](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_data_dir)**
- **[SENZING_DATA_DEB_FILENAME](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_data_deb_filename)**
- **[SENZING_DEB_DIR](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_deb_dir)**
- **[SENZING_ETC_DIR](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_etc_dir)**
- **[SENZING_G2_DIR](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_g2_dir)**
- **[SENZING_VAR_DIR](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_var_dir)**

## Create Project Directory and Mount Volumes
As with any project, we'll start by creating our main directory. To do this, we'll create a `SENZING_VOLUME` environment variable, which will server as our master directory.

```console
SENZING_VOLUME=/opt/senzing-tutorial
```

**Note:** It is convention to mount volumes in the `/opt/` directory on linux, if you are on Windows or Mac you may place it ___.

Fundamentally, there's four environment variables that we need to set up before we can run the container. This will tell the container where to place our files when it runs `apt install senzingapi`. You can make them any path, but it is convention to organise them as follows.
- `SENZING_DATA_DIR=${SENZING_VOLUME}/data` To store our data
- `SENZING_G2_DIR=${SENZING_VOLUME}/g2` To ___
- `SENZING_ETC_DIR=${SENZING_VOLUME}/etc` To ___
- `SENZING_VAR_DIR=${SENZING_VOLUME}/var` To ___

**:warning: Warning:** In a `.env` file, you cannot simply substitute in environment variables like `SENZING_VOLUME` as shown above, instead you may want to replace them manually with the value of `SENZING_VOLUME`, like this:

`.env`:
```.console
SENZING_DATA_DIR=/opt/senzing-tutorial/data
SENZING_G2_DIR=/opt/senzing-tutorial/g2
SENZING_ETC_DIR=/opt/senzing-tutorial/etc
SENZING_VAR_DIR=/opt/senzing-tutorial/var
```

**Note:** If you are running debian linux and wanted to mimic a real DEB installation, here are the directories that you would use

`.env`:
```console
...
SENZING_DATA_DIR=/opt/senzing/data
SENZING_G2_DIR=/opt/senzing/g2
SENZING_ETC_DIR=/etc/opt/senzing
SENZING_VAR_DIR=/var/opt/senzing
```

## Accepting the EULA

To use the Senzing API, you must agree to the End User License Agreement (EULA). Still in your `.env` file, add the [SENZING_ACCEPT_EULA](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_accept_eula) variable.

```console
SENZING_ACCEPT_EULA="I_ACCEPT_THE_SENZING_EULA"
```

**:warning: Warning:** We strongly recommend that you do not simply copy/paste this variable in and instead make a conscious effort to accept the EULA.

## Running the Senzing container
Now that we've set up all of our environment variables, we're ready to run the container using the following command
    
```console
docker run \
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
Note: Since the commands can get quite long, it's not a bad idea to place them in a shell script (start.sh) and instead run the script.
Note: If you are using linux, you may need to be sudo to run docker commands. Check [this](https://docs.docker.com/install/linux/linux-postinstall/) guide to use docker as a non-root user.

# Develop with the Senzing Container
Now that we have the docker container installed, we'll show you how to setup your workspace so you can get started with Senzing. 

**Prerequisite software:**
1. [git](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/install-git.md) To clone the repository
1. [make](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/install-make.md) If you want to create a makefile to run the container

## Clone repository
First, clone this repository somewhere on your drive using the following command

```console
git clone https://github.com/Senzing/docker-apt.git
```

Note: If you are unsure of how to clone a github repo, follow [these instructions](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/clone-repository.md).


## Build docker image for development

1. **Option #1:** Using `docker` command and GitHub.

    ```console
    docker build --tag senzing/apt https://github.com/senzing/docker-apt.git
    ```

1. **Option #2:** Using `docker` command and local repository.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    docker build --tag senzing/apt .
    ```

1. **Option #3:** Using `make` command.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    make docker-build
    ```

    Note: `sudo make docker-build-development-cache` can be used to create cached docker layers.

## Examples
TODO

## Errors
1. See [docs/errors.md](docs/errors.md).

## References
TODO

## See Also
1. [DockerHub](https://hub.docker.com/r/senzing/apt)
    - This image on the docker hub.
1. [Helm Chart](https://github.com/Senzing/charts/tree/master/charts/senzing-apt)
