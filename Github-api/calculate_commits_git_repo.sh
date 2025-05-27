#!/bin/bash

# Declaring variables dynamically
API_URL="https://api.github.com/repos"
OWNER=$1
REPO=$2
GIT_USERNAME=$GIT_USERNAME  # Make sure this is set in your environment
GIT_TOKEN=$GIT_TOKEN        # Make sure this is set in your environment

# Check if the environment variables are set
if [ -z "$GIT_USERNAME" ] || [ -z "$GIT_TOKEN" ]; then
    echo "Error: GitHub username or token is not set in the environment variables."
    exit 1
fi

# Initialize variables with static values
PER_PAGE=30
PAGE=1
TOTAL_COMMITS=0

# Help function to check if user is giving valid input or not.
help_fun() {
    number_of_args=2
    if [ $# -ne $number_of_args ]; then
        echo "Please provide valid input: OWNER REPO."
        exit 1
    fi
}

# Function to get the total number of commits
function get_total_commits() { 
    while true; do
        # Make the API request and fetch commit data
        RESPONSE=$(curl -s -u "$GIT_USERNAME:$GIT_TOKEN" "$API_URL/$OWNER/$REPO/commits?per_page=$PER_PAGE&page=$PAGE")
        
        # Check if the response is empty or API limit reached
        if echo "$RESPONSE" | grep -q "rate limit exceeded"; then
            echo "API rate limit exceeded. Please try again later."
            exit 1
        fi

        # If the API request fails (status code not 200), exit with error
        if [ $? -ne 0 ]; then
            echo "Error: Failed to fetch commit data. Please check your internet connection or API access."
            exit 1
        fi

        # Count commits on the current page
        PER_PAGE_COMMITS=$(echo "$RESPONSE" | jq '.[] | .commit.author.name' | wc -l)

        # If no commits are returned, exit the loop
        if [ "$PER_PAGE_COMMITS" -eq 0 ]; then
            break
        fi

        # Add the number of commits on this page to the total count
        TOTAL_COMMITS=$((TOTAL_COMMITS + PER_PAGE_COMMITS))

        # Move to the next page
        PAGE=$((PAGE + 1))

    done

    # Output the total number of commits
    echo "Total number of commits: $TOTAL_COMMITS"
}

# Putting both functions inside the main function
main() {
    # Call the help function to validate input arguments
    help_fun "$@"
    
    # Call the actual function to get commits if input is valid
    get_total_commits
}

# Run the main function
main "$@"
