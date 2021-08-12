FROM greenrhyno/tesseract-olap:v0.14.13

ARG APP_ROOT /app

ENV SCHEMA_PATH ${APP_ROOT}/schema.xml
COPY ./schema.xml ${SCHEMA_PATH}

# set schema path env var here, and set the rest when running container
#  so that the image does not have to be rebuilt for different environments
ENV TESSERACT_SCHEMA_FILEPATH ${SCHEMA_PATH}

CMD ["tesseract-olap", "-a", "0.0.0.0:7777"]
