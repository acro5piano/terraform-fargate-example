#!/bin/bash

export AWS_SHARED_CREDENTIALS_FILE=$PWD/aws-credentials.ini
export AWS_PROFILE=default
export AWS_REGION=us-east-1

fargate $@
