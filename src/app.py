#! /usr/bin/env python

import dotenv
import flask
import math
import os
import random
import socket
import run_report_task

dotenv.load_dotenv()

app = flask.Flask(__name__)
app.config["DEBUG"] = True


@app.route('/', methods=['GET'])
def home():
    url = "/message?name=Apollo"
    return "Try GET <a href=\"{u}\">{u}</a>\n".format(u=url)


@app.route('/version', methods=['GET'])
def version():
    return "B"


@app.route('/message', methods=['GET'])
def message():
    name = flask.request.args.get('name')
    t = "Hello {name}! I'm {host}. Your lucky number is: {n}\n"
    return t.format(
        name=name,
        host=socket.gethostname(),
        n=get_lucky_number(name)
    )


@app.route('/report', methods=['POST'])
def report():
    name = flask.request.form.get('name')
    response = run_report_task.run_report_task(name)
    print(response)  # lambda logs
    return '202 Accepted\n'  # http response


def get_lucky_number(name):
    random.seed(name)
    f = random.random()*1000
    n = math.trunc(f)
    return n


if __name__ == "__main__":
    port = os.environ['PORT']
    app.run(host='0.0.0.0', port=port)
