#! /usr/bin/env python

# pip install flask
import flask
import func

app = flask.Flask(__name__)
app.config["DEBUG"] = True

@app.route('/', methods=['GET'])
def home():
    url = "/message?name=Apollo"
    return "Try GET <a href=\"{u}\">{u}</a>".format(u=url)

@app.route('/message', methods=['GET'])
def message():
    return func.get_message('Apollo')

app.run(host='0.0.0.0')
