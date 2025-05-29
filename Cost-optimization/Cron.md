# Crontab: Setup & Best Practices for Scheduling Shell Scripts

## 📋 Steps to Schedule a Shell Script with Cron

### 1️⃣ Make Your Script Executable
```bash
chmod +x /path/to/your/script/two.sh
```

---

### 2️⃣ Edit Your Crontab File
- Open your user's crontab file in the default text editor:
  ```bash
  crontab -e
  ```
- Add a cron job entry for your script. The cron job follows this format:

  ```
  * * * * * /path/to/your/script/two.sh
  ┬ ┬ ┬ ┬ ┬
  │ │ │ │ │
  │ │ │ │ └── Day of the week (0 - 6) (Sunday=0)
  │ │ │ └──── Month (1 - 12)
  │ │ └────── Day of the month (1 - 31)
  │ └──────── Hour (0 - 23)
  └────────── Minute (0 - 59)
  ```

- **Example:** To run your script every Monday at 3:00 AM:
  ```
  0 3 * * 1 /path/to/your/script/two.sh
  ```

---

### 3️⃣ Save and Exit the Crontab Editor

---

### 4️⃣ Verify Your Cron Job
```bash
crontab -l
```

---

## ⚠️ Important Notes

### 🟠 Environment Variables

- The environment in cron may differ from your interactive shell.
- If your script requires environment variables (e.g., `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_PROFILE`, `PATH`), **set them explicitly either in your script or inline in the crontab.**

  **Example:**
  ```bash
  export AWS_ACCESS_KEY_ID="your-access-key"
  export AWS_SECRET_ACCESS_KEY="your-secret-key"
  ```

- **Inline Example (for daily run at 3:00 AM):**
  ```bash
  0 3 * * * AWS_ACCESS_KEY_ID="XXXXX" AWS_SECRET_ACCESS_KEY="XXXXX" /home/ubuntu/scripts/two.sh
  ```

---

### 🟠 Logging Output

- Capture output and errors for debugging:
  ```bash
  0 3 * * * AWS_ACCESS_KEY_ID="XXXXX" AWS_SECRET_ACCESS_KEY="XXXXX" /home/ubuntu/scripts/two.sh >> /home/ubuntu/logs/cronjob.log 2>&1
  ```
  - `2>&1` redirects stderr (2) to the same location as stdout (1).

---

### 🟠 AWS Profile Management

- List AWS profiles programmatically:
  ```bash
  aws configure list-profiles
  ```
- View AWS credentials file:
  ```bash
  cat ~/.aws/credentials
  ```

---

## ✅ Summary

- **Make scripts executable**
- **Edit crontab with `crontab -e`**
- **Set necessary environment variables**
- **Redirect output to logs for debugging**
- **Verify your jobs with `crontab -l`**

---