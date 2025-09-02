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

## Use

1. Run Docker container.
   Example:

   ```console
   docker run \
     --rm \
     senzing/apt list -a | grep senzingsdk
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

## References

1. [Development]
1. [Errors]
1. [Examples]

[Development]: docs/development.md
[Errors]: docs/errors.md
[Examples]: docs/examples.md
[Senzing Garage]: https://github.com/senzing-garage
[Senzing Quick Start guides]: https://docs.senzing.com/quickstart/
[SENZING_ACCEPT_EULA]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_accept_eula
[SENZING_API_DEB_FILENAME]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_api_deb_filename
[SENZING_DATA_DEB_FILENAME]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_data_deb_filename
[SENZING_DATA_DIR]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_data_dir
[SENZING_DEB_DIR]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_deb_dir
[SENZING_G2_DIR]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_g2_dir
[Senzing]: https://senzing.com/
