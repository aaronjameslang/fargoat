#! /usr/bin/env python

import sys
import func
import requests

url = sys.argv[1]
name = sys.argv[2]

msg = func.get_message(name)
requests.post(url, data = msg)
