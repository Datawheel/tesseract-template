# Tesseract API Template

## pytesseract

This is a Tesseract API template for projects using the python [tesseract-olap](https://github.com/Datawheel/tesseract-python) package. To start using this template, just create a new repository from this template and start coding 🎉

## Development

The first thing you need to do before working with this repository is setup the local environment variables. The `example.env` contains a list of all the variables needed and available; you can rename this file to `.env.local` and change the values to use them later. With this name, the file will not be checked into version control.

### Using a virtual environment

If you want to work more closely with packages, you can create a virtual environment, install the dependencies, and run the app directly.

#### Install dependencies

To handle dependencies we use [poetry](https://python-poetry.org/). It's kinda like a pip replacement, but also takes care of creating the virtual environment for you, and resolve conflicts between dependencies. To initialize the project, run:

```sh
# this will ensure poetry will put the virtual environment in the ./.venv folder
$ poetry config virtualenvs.in-project true
# initialize venv and install dependencies
$ poetry install
```

#### Run server in development mode

The app follows the ASGI Python pattern, so to run it needs an external server controller. Upon installing the requirements, you will have [granian](https://github.com/emmett-framework/granian/) available in your virtual environment, so you can run the app using:

```
(.venv) $ granian --interface asgi app:layer
```

You can use more [granian options](https://github.com/emmett-framework/granian/#options) to customize your local setup.

### Using Docker to Develop

Running the app in docker helps to debug how the app will behave in production. Read how to [install Docker](https://docs.docker.com/engine/install/) on your local machine.

#### Build your container

If you want to build your container on Docker run `docker build -t <PROJECT_NAME>-tesseract .`. If your app require environment variables at buildtime, remember to call them on the Dockerfile and use them adding `--build-arg <ENV_NAME>=<ENV_VALUE>` per variable to the build command

#### Run you container

Before you can test your container, remember to update the variables inside your `.env.local` file to the latest values, those will be used later at runtime

To run the recently builded image use the command `docker run --rm --env-file=./.env.local -p 7777:7777 <PROJECT_NAME>-tesseract-api` on the folder where `.env.local` is located. If you want to run the app on the background, change the `--rm` flag to `-d`

---
### References
- [https://www.docker.com/](https://www.docker.com/)
- [https://docs.docker.com/](https://docs.docker.com/)
- [https://docs.docker.com/engine/reference/commandline/build/#-set-build-time-variables---build-arg](https://docs.docker.com/engine/reference/commandline/build/#-set-build-time-variables---build-arg)
