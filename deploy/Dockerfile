ARG PYTHON_VERSION

FROM python:${PYTHON_VERSION}-slim-bullseye AS build

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_VERSION=1.6.1

RUN apt-get update \
    && apt-get upgrade -y \
	&& apt-get install -y --no-install-recommends postgresql-client \
	&& rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip \
    && pip install "poetry==$POETRY_VERSION"

WORKDIR /usr/src/app

COPY pyproject.toml poetry.lock ./

RUN poetry install --only main

EXPOSE 8000


FROM build AS dev

RUN poetry install --only dev

ENV APP_DEBUG=1 \
    PYDEVD_DISABLE_FILE_VALIDATION=1

CMD python -m debugpy --listen 0.0.0.0:5678 manage.py runserver 0.0.0.0:8000 --nothreading


FROM build

COPY rebook .

CMD python manage.py runserver 0.0.0.0:8000
