#!/bin/bash

# Declaring both static and dynamic variables.
aws_region=$1
aws_service=$2
number_of_args=2

# Validating weather user is passing required 2 arguments or not .
if [ $# -ne $number_of_args ]; then
    echo "Please enter both the required positional arguments in order to run the script."
    exit
fi

# Check if aws cli is configred or not.
if ! aws --version; then
    echo "AWS CLI is not installed, please install aws cli first."
    exit 1
fi

# Check if aws cli is configured or not.
if [ ! -d ~/.aws ]; then
    echo " If /home/ubuntu/.aws directory does not exist in that case you need to configure aws cli using aws configure command."
    exit 1
fi

case $aws_service in
    EC2)
        echo "We are listing ec2 server running in a particular region"
        aws ec2 describe-instances --region $aws_region
        ;;
    S3)
        echo "Listing S3 Buckets in $aws_region"
        aws s3api list-buckets --region $aws_region
        ;;
    IAM)
        echo "Listing IAM Users in $aws_region"
        aws iam list-users --region $aws_region
        ;;
    EBS)
        echo "Listing EBS Volumes in $aws_region"
        aws ec2 describe-volumes --region $aws_region
        ;;
    ELB)
        echo "Listing Elastic load balancer in $aws_region"
        aws elb describe-load-balancers --region $aws_region
        ;;
    EKS)
        echo "Listing Elastic Kubernetes cluster in $aws_region"
        aws aws eks list-clusters --region $aws_region
        ;;
    *)
        echo "Please enter the valid input."
        exit 1
        ;;
esac