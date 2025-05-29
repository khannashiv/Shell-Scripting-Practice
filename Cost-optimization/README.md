## Cost optimization scirpt goal & explaination of script.


🧠 Cost Optimization Strategy for ELK Stack with Jenkins Logs
The customer was using an observability solution based on the ELK Stack — consisting of Elasticsearch, Logstash, and Kibana — to collect, store, and analyze logs from multiple sources. The stack was self-hosted on virtual machines (VMs) running in a cluster, with Elasticsearch backed by persistent storage volumes.

📦 Logs Ingested into ELK Stack Included:
    Application logs from over 100 microservices
    Kubernetes control plane logs
    Infrastructure logs, including:
    Jenkins logs across multiple environments (Prod, Stage, UAT)
    Business application logs (Finance, Banking, etc.)

🚨 Problem Statement

The ELK stack incurred significant operational and storage costs, primarily due to the high volume of logs being ingested and retained. Among these, Jenkins build logs were being stored only for backup purposes — no meaningful analysis or search was being performed on them within ELK.

Additionally, Jenkins already had mechanisms in place to share build failure logs with developers via:

    📧 Email
    💬 Slack notifications

Hence, storing Jenkins logs in ELK provided little value while increasing storage and infrastructure costs.

💡 Proposed Solution
To reduce unnecessary ELK storage costs, we proposed an alternative logging strategy for Jenkins logs using Amazon S3, a low-cost and highly durable object storage service.

🛠️ Implementation Details:
A shell script is deployed on the Jenkins server.
    This script is scheduled to run daily at midnight via a cron job.
    The script performs the following:
    Navigates to the Jenkins builds directory.
    Iterates over each build and the corresponding log files.
    Uploads all log files to a designated S3 bucket using aws s3 cp or sync.