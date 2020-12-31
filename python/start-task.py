#! /usr/bin/env python

import boto3
import dotenv
import os
import subprocess

dotenv.load_dotenv()

client = boto3.client('ecs', region_name=os.environ['REGION'])

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ecs.html#ECS.Client.run_task0

cluster = '{pn}-{st}-cluster0'.format(
    pn=os.environ['PROJECT_NAME'],
    st=os.environ['STAGE'],
)
taskDefinition = '{pn}-{st}-taskDefinition0'.format(
    pn=os.environ['PROJECT_NAME'],
    st=os.environ['STAGE'],
)
out, err = subprocess.Popen('./scripts/subnet-id.sh', stdout=subprocess.PIPE).communicate()

response = client.run_task(
    cluster=cluster,
    launchType='FARGATE',
    networkConfiguration={
        'awsvpcConfiguration': {
            'subnets': [ out.strip() ],
            'assignPublicIp': 'ENABLED'
        }
    },
    overrides={
        'containerOverrides': [
            {
                'name': 'container0',
                'command': [
                    './async.py',
                    os.environ['WH_URL'],
                    os.environ['USER']
                ],
            },
        ],
    },
    taskDefinition=taskDefinition
)

print response
