FROM python:2

RUN pip install flask
COPY ./python ./
CMD ./server.py
