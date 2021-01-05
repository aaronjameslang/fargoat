#! /usr/bin/env python

import dotenv
import faker
import math
import os
import random
import requests
import socket
import sys

dotenv.load_dotenv()

def report(name):
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
            x=math.trunc(random.normalvariate(800, 300))
        )
    print(report_tsv) # log on server
    url=os.environ['WEBHOOK_URL']
    requests.post(url, data = report_tsv) # send to client
    return 'Report will be submitted to '+url+'\n'

def get_lucky_number(name):
    random.seed(name)
    f = random.random()*1000
    n = math.trunc(f)
    return n

if __name__ == "__main__":
    report(sys.argv[1])
