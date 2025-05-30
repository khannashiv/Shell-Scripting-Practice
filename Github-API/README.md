## Calculating total number of commmits made to git repository.

- Refrence
    - https://docs.github.com/en/rest/quickstart?apiVersion=2022-11-28
    - https://docs.github.com/en/rest/commits/commits?apiVersion=2022-11-28
    - https://docs.github.com/en/rest/using-the-rest-api/using-pagination-in-the-rest-api?apiVersion=2022-11-28
    - https://docs.aws.amazon.com/cli/latest/reference/
    - https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

<!-- 
    #### Sample api calls taken from official documentation & testing done locally.

    curl -L \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer <YOUR-TOKEN>" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        https://api.github.com/repos/OWNER/REPO/commits
 
    get /repos/{owner}/{repo}/commits

    ## Replacing required fields in the above api call for demonstration.

     - owner : khannashiv
     - repo : Kubernetes-Practice
     - Modified URL : https://api.github.com/repos/khannashiv/Kubernetes-Practice/commits
  
    ## Testing locally.

     - curl https://api.github.com/repos/khannashiv/Kubernetes-Practice/commits --- > This is giving me an output in json format .
     - curl "https://api.github.com/repos/khannashiv/Kubernetes-Practice/commits?per_page=30&page=1"
     - curl "https://api.github.com/repos/khannashiv/Kubernetes-Practice/commits?per_page=30&page=2"
     - curl "https://api.github.com/repos/khannashiv/Kubernetes-Practice/commits?per_page=30&page=3"

    ## We can print maximum 100 items/commits in single page.

       - curl "https://api.github.com/repos/khannashiv/Kubernetes-Practice/commits?per_page=100&page=1"
       - curl "https://api.github.com/repos/khannashiv/Kubernetes-Practice/commits?per_page=500" --- > But it accepting max of 100 commits as written in official documentation.

    ## In the below command, we are silently taking an output of curl and saving the output in comit.json file & eventually calculating the count of commits made by owner of repo.
    
        - curl -s https://api.github.com/repos/khannashiv/Kubernetes-Practice/commits -o commit.json && jq '.[] | .commit.author.name' commit.json | wc -l

    ## We need to explicitly define/run environment variables for preforming authentication since due to security reasons we cannot pass them directly to our shell script.

       - export GITHUB_TOKEN="XXXXXXXXXXXXXXXX"
       - export GIT_USERNAME="XXXXXXXXXXXXX"

     Q: Meaning of : if [ -z "$GIT_USERNAME" ] || [ -z "$GIT_TOKEN" ]; then ?
     S: This checks if either the environment variable GIT_USERNAME or the environment variable GIT_TOKEN is empty or unset.

        - [ -z "$GIT_USERNAME" ]   : The -z tests if the string is zero length (empty).
        - || : Logical OR operator : The condition passes if either side is true.
        - [ -z "$GIT_TOKEN" ]      : Same test for GIT_TOKEN.
        - If either variable is empty or missing, then the code inside the then block runs:

            - echo "Error: GitHub username or token is not set in the environment variables."
            - Prints an error message to the terminal.
            - exit 1
            - Exits the script immediately with a status code of 1, which generally signals an error.
        -

     Q: Instead of using echo "$RESPONSE", Can I also write cat "$RESPONSE" ?
     S: No, you cannot replace echo "$RESPONSE" with cat "$RESPONSE" .
        - RESPONSE is a variable holding the API response as a string, not a filename.
        - echo "$RESPONSE" prints the contents of the variable.
        - cat "$RESPONSE" tries to open a file named after the content of $RESPONSE, which almost certainly does not exist, and will cause an error.
        - If you want to use cat, you'd need to first save the response into a file, 
            - e.g. : echo "$RESPONSE" > response.txt
            - cat response.txt | grep -q "rate limit exceeded"
                - grep -q "rate limit exceeded" searches quietly for the string "rate limit exceeded" in the response.
        - "$@"  - expands to all the arguments individually quoted, preserving spaces and special characters.
                - "$@" preserves the boundaries between arguments, even if some have spaces.
                - NOTE : Using $@ without quotes would join all arguments into a single string, which could cause problems.
    -->

    