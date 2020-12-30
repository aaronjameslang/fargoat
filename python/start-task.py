#! /usr/bin/env python

import boto3
import dotenv
import os

dotenv.load_dotenv()

client = boto3.client('ecs', region_name=os.environ['REGION'])

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ecs.html#ECS.Client.run_task0

response = client.run_task(
    cluster='fargoat-dev-cluster0',
    launchType='FARGATE',
    networkConfiguration={
        'awsvpcConfiguration': {
            'subnets': [ 'subnet-0ab6a4f9471652333' ],
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
    taskDefinition='fargoat-dev-taskDefinition0'
)

print response
