#!/bin/bash

# Enabling debug mode.
set -x

# Get current timestamp to append to filenames
timestamp=$(date +"%Y-%m-%d_%H:%M:%S")

# Define output directory
output_dir="aws_output"
mkdir -p "$output_dir"

# Function to list AWS S3 buckets
list_s3_buckets() {
    echo "Listing all S3 buckets in AWS account..."
    if ! aws s3api list-buckets --output json > "$output_dir/s3_buckets_$timestamp.json"; then
        echo "Failed to list S3 buckets."
        exit 1
    fi
    echo "S3 buckets listed successfully."
}

# Function to list AWS EC2 instances
list_ec2_instances() {
    echo "Listing all EC2 instances running under AWS account..."
    if ! aws ec2 describe-instances --output json > "$output_dir/ec2_instances_$timestamp.json"; then
        echo "Failed to list EC2 instances."
        exit 1
    fi
    echo "EC2 instances listed successfully."
}

# Function to list AWS IAM users
list_iam_users() {
    echo "Listing IAM users..."
    if ! aws iam list-users --output json > "$output_dir/iam_users_$timestamp.json"; then
        echo "Failed to list IAM users."
        exit 1
    fi
    echo "IAM users listed successfully."
}

# Function to list AWS Elastic Load Balancers
list_load_balancers() {
    echo "Listing Elastic Load Balancers..."
    if ! aws elb describe-load-balancers --output json > "$output_dir/load_balancers_$timestamp.json"; then
        echo "Failed to list load balancers."
        exit 1
    fi
    echo "Load balancers listed successfully."
}

# Function to list AWS EKS clusters
list_eks_clusters() {
    echo "Listing EKS clusters..."
    if ! aws eks list-clusters --output json > "$output_dir/eks_clusters_$timestamp.json"; then
        echo "Failed to list EKS clusters."
        exit 1
    fi
    echo "EKS clusters listed successfully."
}

# Main execution
list_s3_buckets
list_ec2_instances
list_iam_users
list_load_balancers
list_eks_clusters

echo "Script executed successfully."

