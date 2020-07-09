FROM python:3.8.3-slim-buster

WORKDIR /usr/src/app

RUN pip install --no-cache-dir kubernetes

COPY ./endpoints.py .

CMD [ "python", "./endpoints.py" ]