FROM python:2

COPY ./python ./
RUN pip install flask

CMD ./server.py
