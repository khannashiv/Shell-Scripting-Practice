#!/bin/bash
##########################################
# Script to upload / shift Jenkins logs from ELK to S3 Bucket for doing cost optimization. 

# We can add line # 8 (that indicates log upload process) before uploading the logs to S3 bucket i.e. at line # 47.
# For simplicity we have skipped it for now .
# echo "$(date +%Y-%m-%d_%H:%M:%S) - Uploading $build_logs to $s3_path"
# We have implemented cron-job to this shell script as well.
##########################################

# Enabling debug mode.
set -x

# This command is used in Bash to make your script exit immediately if any command returns a non-zero (error) status.
set -e

# Declaring variables
Jenkins_HOME="/var/lib/jenkins"
S3_URL="s3://jenkins-jobs-build-logs"
Timestamp=$(date +%Y-%m-%d_%H-%M-%S)  # Added time to make it unique

# Check if AWS CLI is installed
if ! aws --version >> /dev/null; then
    echo "AWS-CLI not found on the machine. Please install it as a prerequisite."
    exit 1
fi

# Iterate over each job
for jobs in "$Jenkins_HOME/jobs/"*/; do
    job_name=$(basename "$jobs")

    # Iterate over each build in the job's builds folder
    for builds in "${jobs}builds/"*/; do
        build_number=$(basename "$builds")
        build_logs="${builds}log"

        # Check if log file exists before attempting to upload
        if [ ! -f "$build_logs" ]; then
            echo "Log file not found for build #$build_number in job $job_name. Skipping..."
            continue
        fi

        # Construct the S3 path with job name, build number, and timestamp
        s3_path="${S3_URL}/${job_name}/build_${build_number}_log_${Timestamp}.log"

        # Upload the log to S3
        aws s3 cp "$build_logs" "$s3_path"

        # Check the upload success
        if [ $? -eq 0 ]; then
            echo "Files uploaded successfully: $build_logs to $s3_path"
        else
            echo "Error uploading $build_logs to S3. Exiting."
            exit 1
        fi
    done
done

