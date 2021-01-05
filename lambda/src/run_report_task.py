#! /usr/bin/env python

import boto3
import dotenv
import os
import sys

dotenv.load_dotenv()


def run_report_task(name):
    client = boto3.client('ecs', region_name=os.environ['REGION'])

    cluster = '{pn}-ecs-{st}-cluster0'.format(
        pn=os.environ['PROJECT_NAME'],
        st=os.environ['STAGE'],
    )
    taskDefinition = '{pn}-ecs-{st}-taskDefinition0'.format(
        pn=os.environ['PROJECT_NAME'],
        st=os.environ['STAGE'],
    )

    response = client.run_task(
        cluster=cluster,
        launchType='FARGATE',
        networkConfiguration={
            'awsvpcConfiguration': {
                'subnets': [os.environ['SUBNET_ID']],
                'assignPublicIp': 'ENABLED'
            }
        },
        overrides={
            'containerOverrides': [
                {
                    'name': 'container0',
                    'command': ['./app.report.py', name],
                },
            ],
        },
        taskDefinition=taskDefinition
    )

    return response


if __name__ == "__main__":
    response = run_report_task(sys.argv[1])
    print(response)
