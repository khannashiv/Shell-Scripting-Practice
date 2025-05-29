# Cost Optimization Script — Goal & Explanation

## 🧠 Overview: Cost Optimization Strategy for ELK Stack with Jenkins Logs

The customer was using an observability solution based on the **ELK Stack**—comprising **Elasticsearch**, **Logstash**, and **Kibana**—to collect, store, and analyze logs from multiple sources. While effective, this approach resulted in high operational and storage costs due to the sheer volume of logs being ingested and retained.

---

## 📦 Types of Logs Ingested into ELK Stack

- Application logs from **100+ microservices**
- **Kubernetes** control plane logs
- Infrastructure logs, including:
  - Jenkins logs (across Prod, Stage, UAT)
  - Business application logs (Finance, Banking, etc.)

---

## 🚨 Problem Statement

The ELK stack incurred significant costs, mainly due to the large volume and retention of logs. In particular, **Jenkins build logs** were being stored only for backup/reference, but were seldom accessed via ELK.

**Note:** Jenkins already has built-in mechanisms to notify developers of build failures via:
- 📧 Email
- 💬 Slack notifications

Thus, storing Jenkins logs in ELK provided minimal added value while increasing storage and infrastructure expenses.

---

## 💡 Proposed Solution

To reduce unnecessary ELK storage costs, an alternative logging strategy for Jenkins logs was proposed:

- Store Jenkins logs in **Amazon S3**—a low-cost, highly durable object storage service.
- Remove Jenkins log ingestion from ELK, keeping only critical logs.

---

## 🛠️ Implementation Details

- A **shell script** is deployed on the Jenkins server.
- This script is scheduled to run **daily at midnight** via a cron job.
- The script performs the following steps:
  1. Navigates to the Jenkins builds directory.
  2. Iterates over each build and its corresponding log files.
  3. Uploads all log files to a designated **S3 bucket** using `aws s3 cp` or `aws s3 sync`.

---

## ✅ Benefits

- **Cost Savings:** Significant reduction in ELK storage and operational costs.
- **No Loss of Functionality:** Developers still receive failure

<!-- 

 -->