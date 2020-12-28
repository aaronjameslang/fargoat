FROM python:2

RUN pip install flask
CMD ./server.py

COPY ./python ./
