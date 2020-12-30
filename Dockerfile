FROM python:2

RUN pip install flask requests
CMD false

COPY ./python ./
