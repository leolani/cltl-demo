# syntax = docker/dockerfile:1.2

FROM python:3.9

WORKDIR /demo
COPY src config requirements.txt ./

RUN --mount=type=bind,target=/demo/repo,from=cltl/requirements:0.0.1,source=/repo \
        pip install --no-cache-dir -r requirements.txt

CMD python app.py --rest --event

EXPOSE 5000
