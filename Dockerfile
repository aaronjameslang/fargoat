FROM python:2

RUN pip install flask
CMD false

COPY ./python ./
