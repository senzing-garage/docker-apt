# docker-apt examples

## Examples of Docker

The following examples require initialization described in
[Demonstrate using Docker].

### Installing SenzingSDK

#### EULA

To use the Senzing code, you must agree to the End User License Agreement (EULA).

1. :warning: This step is intentionally tricky and not simply copy/paste.
   This ensures that you make a conscious effort to accept the EULA.
   Example:

    <pre>export SENZING_ACCEPT_EULA="&lt;the value from <a href="https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_accept_eula">this link</a>&gt;"</pre>

#### Docker volumes

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

#### Run Docker container

1. Run Docker container.
   Example:

   ```console
   docker run \
     --env SENZING_ACCEPT_EULA=${SENZING_ACCEPT_EULA} \
     --rm \
     --user 0 \
     --volume ${SENZING_VOLUME}:/opt/senzing \
     senzing/apt install -y senzingsdk-runtime
   ```

### Manually accept EULA

By not setting `SENZING_ACCEPT_EULA_PARAMETER`, the containerized `yum` install will prompt for manual EULA acceptance.

1. Run Docker container.
   Example:

   ```console
   sudo docker run \
     --interactive \
     --rm \
     --tty \
     --volume ${SENZING_VOLUME}:/opt/senzing \
     senzing/apt install -y senzingsdk-runtime
   ```

### Install local DEB files

`senzing/apt` can be used to install local DEB files.

1. To download Senzing DEB file, see
   [github.com/Senzing/docker-aptdownloader].

1. :pencil2: Set additional environment variables.
   Identify directory containing DEB files and the exact names of the DEB files.
   Example:

   ```console
   export SENZING_DEB_DIR=~/Downloads
   export SENZING_API_DEB_FILENAME=senzingsdk-nn.nn.nn.x86_64.rpm
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
