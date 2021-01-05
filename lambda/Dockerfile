FROM python:3.7-alpine

CMD false

COPY .env ./
COPY requirements.* ./
RUN pip install -r requirements.freeze

COPY ./src/app.report.py ./
