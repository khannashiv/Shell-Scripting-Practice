## About Crontab & Some important points to note while setting up cronjob for shell script.

# Step 1: Make your script executable
#     - chmod +x /path/to/your/script/two.sh

# Step 2: Edit the crontab file
#     - crontab -e
#     - This will open your user's crontab file in the default text editor
#     - Add a cron job entry for your script. The cron job follows this format

#                 * * * * * /path/to/your/script/two.sh
#                 ┬ ┬ ┬ ┬ ┬
#                 │ │ │ │ │
#                 │ │ │ │ └─ Day of the week (0 - 6) (Sunday=0)
#                 │ │ │ └──── Month (1 - 12)
#                 │ │ └────── Day of the month (1 - 31)
#                 │ └──────── Hour (0 - 23)
#                 └────────── Minute (0 - 59)
#     - For example, if you want your script to run every day at 3:00 AM, you would add : 0 3 * * 1 /path/to/your/script/two.sh

# Step 3: Save and exit the crontab editor

# Step 4: Verify your cron job is added : crontab -l
 
# NOTE : If your script requires environment variables (like AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_PROFILE, PATH, etc.), 
#   make sure to set them in the script or in the crontab.

#     M1. Environment Variables: 
#         When running scripts via cron, the environment might not be the same as when running the script manually. 
#         If your script requires environment variables (like AWS_PROFILE, PATH, etc.), make sure to set them in the script or in the crontab.

#             - export AWS_ACCESS_KEY_ID="your-access-key"
#             - export AWS_SECRET_ACCESS_KEY="your-secret-key"

#     M2. In your crontab, if you want to run this script daily at 3:00 AM, while passing these AWS credentials inline, 
#         the cron job entry would look like this:

#    for example : 0 3 * * * AWS_ACCESS_KEY_ID="XXXXX" AWS_SECRET_ACCESS_KEY="XXXXX" /home/ubuntu/scripts/two.sh

# Logging Output:

# - It's a good practice to capture the output and errors of your cron jobs.
# - You can redirect them to a log file to debug any issues later, like shown below.
# - for example : 0 3 * * * AWS_ACCESS_KEY_ID="XXXXX" AWS_SECRET_ACCESS_KEY="XXXXX" /home/ubuntu/scripts/two.sh >> /home/ubuntu/logs/cronjob.log 2>&1
# - 2>&1 means "redirect stderr (2) to the same location as stdout (1)".

# aws configure list-profiles ---> If we want to get list aws profiles programmatically.
# cat ~/.aws/credentials      ---> The other way to get list of aws profiles.