# Tesseract API Template

## pytesseract

This is a Tesseract API template for projects using the [tesseract-api](https://github.com/tesseract-olap/tesseract) package. To start using this template, just create a new repository from this template and start coding 🎉

## Docker

### Use of local environments

If you are using node directly to develop, please recall your typical `.env` file to `.env.local`. For this, use `.env` as a guide

### Using Docker to Develop

1. [Install Docker](https://docs.docker.com/engine/install/) on your machine
2. Build your container with:
  - NO ENV VARS AT BUILDTIME: `docker build -t <PROJECT_NAME>-tesseract-api .`
  - WITH ENV VARS AT BUILDTIME: `docker build --build-arg <ENV_NAME>=<ENV_VALUE> -t <PROJECT_NAME>-tesseract-api .`
3. Run your container with:
  - `docker run --rm --env-file=./.env.local -p 7777:7777 <PROJECT_NAME>-tesseract-api`
