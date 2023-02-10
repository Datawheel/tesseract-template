FROM python:3.7

# install required dependencies
RUN pip install -U pip setuptools wheel

# allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED True

# define work directory
ENV APP_HOME /usr/src/app
WORKDIR $APP_HOME

# transfer python requirements
COPY requirements.txt ./

# install python requirements on environment
RUN useradd -m -r tesseract &&\
    chown tesseract $APP_HOME &&\
    pip install --no-cache-dir -r requirements.txt

# transfer app files
COPY . .

# define git hash
ARG GIT_HASH
ENV GIT_HASH=${GIT_HASH:-dev}

# change user to tesseract user
USER tesseract

# expose the required port
ENV PORT 7777
EXPOSE 7777

# setup host and port for cloudrun
#ENV HOST 0.0.0.0

# define startup commands
# CMD ["python", "app.py"]

CMD ["app.py"]
ENTRYPOINT ["python"]