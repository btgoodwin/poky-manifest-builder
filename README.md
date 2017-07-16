# Generic Yocto/Poky Manifest Builder

This Docker image is meant to be a simple repo manifest build runner for Yocto/Poky -based targets, similar to as defined in Geon's [meta-redhawk-sdr-manifests](https://github.com/GeonTech/meta-redhawk-sdr-manifests).

This image has been tested on Docker-CE 17.06 on macOS Sierra.

## Installation

Either pull the image from Docker Hub or build it using this Dockerfile.

1. Pull:
 
    docker pull geontech/poky-manifest-builder

2. Build:

    docker build --rm -t geontech/poky-manifest-builder .

## Compatible Usage

The workflow of running containers with this image is that the user specifies the following environment variables:

The repo-delivered filesystem layout should be similar to the following.

```
[workspace]
    /build/build-image.sh
    /poky
        /oe-init-build-env
        /bitbake
        /meta-...
```


