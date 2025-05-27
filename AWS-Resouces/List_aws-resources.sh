#!/bin/bash

# For debugging.
set -x

# Listing aws s3 buckets.
echo "Please list the all s3 bucket in my aws account."
aws s3 ls

# Listing aws ec2 instances.
echo "Printing the list of all ec2 instances running under aws account."
aws ec2 describe-instances

# Listing aws iam users.
echo "Printing the list of iam users."
aws iam get-user

# List of aws load balancers.
echo "Please print the list of elastic load balancers."
aws elb describe-load-balancers

# List of eks / kubnerntes clusters.
echo "Printing the list of kubernetes cluster running under aws account."
aws eks list-clusters

echo "Script executed successfully."
