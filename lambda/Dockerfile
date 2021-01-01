FROM python:3.7-alpine

CMD false

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY ./*.py ./
