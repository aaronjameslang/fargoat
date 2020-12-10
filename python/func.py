import math
import random
import socket

def get_message(name):
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
