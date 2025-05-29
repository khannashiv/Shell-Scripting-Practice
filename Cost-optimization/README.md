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
Q: Meaning of : job_name=$(basename "$jobs") ?
S:
    -- The basename command extracts the final component of a given path, regardless of whether that component is a file or a folder.
    -- If jobs="/var/lib/jenkins/jobs/Build-App/", then: job_name=$(basename "$jobs"), O/P is : job_name = "Build-App"
 
 Q: Meaning of : for builds in "${jobs}builds/"*/;
 S: 
  - jobs is a variable that likely holds a directory path ending with a slash, e.g., /some/path/job1/
  - "${jobs}builds/" concatenates the string builds/ to the path stored in jobs, so it points to the builds subdirectory inside that job directory.
  - The */ outside the quotes is a wildcard pattern matching all directories inside the builds/ directory
  - The for builds in ...; do loop iterates over each directory inside that builds folder.
  - "${Jenkins_HOME}/jobs/" or "${jobs}builds/"  -- > Why double qoutes ? --- > This is done to safely expand  the variable even if it contains spaces or special characters.So this prevents the shell from misinterpreting the path.

Q: Meaning of s3_path="${S3_URL}/${job_name}/build_${build_number}_log_${Timestamp}.log" ?
S: Above is used in building a full S3 object path (like a filename in a bucket), using variable substitution in Bash.

    | Variable       | Meaning                                                      |
    | -------------- | ------------------------------------------------------------ |
    | `S3_URL`       | The base S3 bucket path, e.g., `s3://my-jenkins-logs-bucket` |
    | `job_name`     | Name of the Jenkins job (e.g., `Build-App`)                  |
    | `build_number` | The number of the Jenkins build (e.g., `123`)                |
    | `Timestamp`    | A timestamp string (e.g., `2025-05-29_18:30:00`)             |

    - So overall we are concatenating strings and variables to form a path like : s3://my-jenkins-logs-bucket/Build-App/build_123_log_2025-05-29_18:30:00.log
    - This will be the destination path when uploading a log file to S3 via the AWS CLI.

 -->