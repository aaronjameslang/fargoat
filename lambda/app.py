#! /usr/bin/env python

# Run as
# $PWD/app.py
# or
# sls wsgi serve

# Test over HTTP
# curl --data name=$USER localhost:5000/report

import dotenv
import faker
import flask
import math
import os
import random
import requests
import socket

dotenv.load_dotenv()

app = flask.Flask(__name__)
app.config["DEBUG"] = True

@app.route('/', methods=['GET'])
def home():
    url = "/message?name=Apollo"
    return "Try GET <a href=\"{u}\">{u}</a>".format(u=url)

@app.route('/version', methods=['GET'])
def version():
    return "B"

@app.route('/message', methods=['GET'])
def message():
    name = flask.request.args.get('name')
    t = "Hello {name}! I'm {host}. Your lucky number is: {n}"
    return t.format(
        name=name,
        host=socket.gethostname(),
        n=get_lucky_number(name)
    )

def get_lucky_number(name):
    random.seed(name)
    f = random.random()*1000
    n = math.trunc(f)
    return n

@app.route('/report', methods=['POST'])
def report():
    name = flask.request.form.get('name')
    fake=faker.Faker()
    faker.Faker.seed(name)
    random.seed(name)
    report_tsv='You ({n})\t{ip}\t{x}'.format(
        n=name,
        ip=socket.gethostbyname(socket.gethostname()),
        x=get_lucky_number(name)
    )
    for _ in range(10):
        report_tsv+='\n{n}\t{ip}\t{x}'.format(
            n=fake.name(),
            ip=fake.ipv4_private(),
            x=random.normalvariate(800, 300)
        )
    print report_tsv # log on server
    url=os.environ['WEBHOOK_URL']
    requests.post(url, data = report_tsv) # send to client
    return 'Report will be submitted to '+url+'\n'


if __name__ == "__main__":
    port=os.environ['PORT']
    app.run(host='0.0.0.0', port=port)
