# Tesseract UI Deploy Files

This directory contains a number of files to deploy instances of Tesseract UI that connect with your deployed Tesseract instances.

## File summaries

### create-cloud-build.sh

Simple script to dynamically create a cloudbuild.yml file to give to Google Cloud Build so that it can build the image properly. (This is needed so that we can pass the build argument properly).

### create-nginx-config.sh

Script to dynamically create NGINX config for Tesseract UI image to properly proxy calls to /tesseract paths to the given Tesseract URL.

### Dockerfile

Dockerfile to create an image of Tesseract UI that points to a specified Tesseract URL. You must pass TESSERACT_URL as a `--build-arg` to the build process for the Docker image to work.

