#!/bin/bash

if ! which fargate; then
    echo 'Fargate CLI not found.'
    echo 'Install it from https://github.com/awslabs/fargatecli/releases'
    exit 1
fi

export AWS_SHARED_CREDENTIALS_FILE=$PWD/aws-credentials.ini
export AWS_PROFILE=default
export AWS_REGION=us-east-1

fargate $@
