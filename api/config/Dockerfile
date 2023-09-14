FROM python:3.11.3-slim-bullseye

WORKDIR /src

RUN apt update \
    && apt upgrade -y
    
COPY config/requirements.txt ./config/

RUN pip install --upgrade pip \
    && pip install -r ./config/requirements.txt

COPY app ./app/

EXPOSE 80

CMD opentelemetry-instrument uvicorn app.main:app --host 0.0.0.0 --port 80