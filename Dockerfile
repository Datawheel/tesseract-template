FROM python:3.10 as builder

RUN pip install setuptools wheel poetry==1.8.3

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

WORKDIR /app

COPY pyproject.toml poetry.lock ./
RUN touch README.md

RUN --mount=type=cache,target=$POETRY_CACHE_DIR poetry install --without dev --no-root

FROM python:3.10-slim-buster as runtime

ENV VIRTUAL_ENV=/app/.venv \
    PATH="/app/.venv/bin:$PATH"

# create runtime user; install required dependencies
RUN useradd --system --uid 1001 tesseract

WORKDIR /app

COPY --chown=tesseract --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}

COPY --chown=tesseract . /app

# change user to tesseract user
USER tesseract

CMD exec granian --interface asgi --host 0.0.0.0 --port 7777 --respawn-failed-workers app:layer
