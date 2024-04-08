FROM python:3.12

# Install api pre requirements
RUN pip install -U pip setuptools wheel

# Define api directory
ENV APP_HOME /usr/src/app
WORKDIR $APP_HOME

# Allow that statements and log messages appear in the Knative logs
ENV PYTHONUNBUFFERED True

# Transfer api requirements
COPY requirements.txt ./

# Install api requirements
RUN useradd -m -r tesseract &&\
    chown tesseract $APP_HOME &&\
    pip install --no-cache-dir -r requirements.txt

# Transfer app files
COPY --chown=tesseract:tesseract  . .
RUN chown -R tesseract $APP_HOME

# Define api required env vars
ARG GIT_HASH
ENV GIT_HASH=${GIT_HASH:-dev}

# Change unix user to tesseract
USER tesseract

# Expose api port
ENV GRANIAN_PORT 7777
EXPOSE 7777

# Setup host and port
# Uncomment this line for a cloudrun instance
#ENV GRANIAN_HOST 0.0.0.0

# Define startup commands
CMD ["--interface", "asgi", "--respawn-failed-workers", "app:layer"]
ENTRYPOINT ["granian"]
