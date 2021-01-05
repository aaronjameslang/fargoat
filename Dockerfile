FROM python:3.7-alpine

CMD false

COPY .env ./
COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY ./src/app.report.py ./
