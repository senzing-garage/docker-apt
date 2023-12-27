# Git variables

GIT_REPOSITORY_NAME := $(shell basename `git rev-parse --show-toplevel`)
GIT_VERSION := $(shell git describe --always --tags --long --dirty | sed -e 's/\-0//' -e 's/\-g.......//')

# Docker variables

DOCKER_IMAGE_TAG ?= $(GIT_REPOSITORY_NAME):$(GIT_VERSION)
DOCKER_IMAGE_NAME := senzing/apt
SENZING_APT_STAGING_REPOSITORY_URL=https://senzing-staging-apt.s3.amazonaws.com/senzingstagingrepo_1.0.0-1_amd64.deb

# -----------------------------------------------------------------------------
# The first "make" target runs as default.
# -----------------------------------------------------------------------------

.PHONY: default
default: help

# -----------------------------------------------------------------------------
# Docker-based builds
# -----------------------------------------------------------------------------

.PHONY: docker-build
docker-build:
	docker build \
		--tag $(DOCKER_IMAGE_NAME) \
		--tag $(DOCKER_IMAGE_NAME):$(GIT_VERSION) \
		.

.PHONY: docker-build-staging
docker-build-staging:
	docker build \
		--build-arg SENZING_APT_REPOSITORY_URL=$(SENZING_APT_STAGING_REPOSITORY_URL) \
		--tag $(DOCKER_IMAGE_NAME)-staging \
		--tag $(DOCKER_IMAGE_NAME)-staging:$(GIT_VERSION) \
		.

# -----------------------------------------------------------------------------
# Clean up targets
# -----------------------------------------------------------------------------

.PHONY: docker-rmi-for-build
docker-rmi-for-build:
	-docker rmi --force \
		$(DOCKER_IMAGE_NAME):$(GIT_VERSION) \
		$(DOCKER_IMAGE_NAME)

.PHONY: docker-rmi-for-build-staging
docker-rmi-for-build-staging:
	-docker rmi --force \
		$(DOCKER_IMAGE_NAME)-staging:$(GIT_VERSION) \
		$(DOCKER_IMAGE_NAME)-staging

.PHONY: clean
clean: docker-rmi-for-build docker-rmi-for-build-staging

# -----------------------------------------------------------------------------
# Help
# -----------------------------------------------------------------------------

.PHONY: help
help:
	@echo "List of make targets:"
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs
