# Tesseract API Template

## pytesseract

This is a Tesseract API template for projects using the [tesseract-api](https://github.com/tesseract-olap/tesseract) package. To start using this template, just create a new repository from this template and start coding 🎉

## Docker

### Use of local environments

If you were using node directly to develop, please recall your `.env` file to `.env.local`. For the purpouse of this template, `.env` is used as the initial example and is not ignored on `.gitignore`

### Using Docker to Develop

Required to [install Docker](https://docs.docker.com/engine/install/) on your environment

#### Build you container

If you want to build your container on Docker run `docker build -t <PROJECT_NAME>-tesseract-api .`. If your app require environment variables at buildtime, remember to call them on the Dockerfile and use them adding `--build-arg <ENV_NAME>=<ENV_VALUE>` per variable to the build command

#### Run you container

Before you can test your container, remember to update the variables inside your `.env.local` file to the latest values, those will be used later at runtime

To run the recently builded image use the command `docker run --rm --env-file=./.env.local -p 7777:7777 <PROJECT_NAME>-tesseract-api` on the folder where `.env.local` is located. If you want to run the app on the background, change the `--rm` flag to `-d`

---
### References
- [https://www.docker.com/](https://www.docker.com/)
- [https://docs.docker.com/](https://docs.docker.com/)
- [https://docs.docker.com/engine/reference/commandline/build/#-set-build-time-variables---build-arg](https://docs.docker.com/engine/reference/commandline/build/#-set-build-time-variables---build-arg)
