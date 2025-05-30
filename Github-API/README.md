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

    ## Replacing required fields in the above api call.

    owner : khannashiv
    repo : Kubernetes-Practice
    Modified URL : https://api.github.com/repos/khannashiv/Kubernetes-Practice/commits
  
    ## Testing locally.

    curl https://api.github.com/repos/khannashiv/Kubernetes-Practice/commits --- > This is giving me an output in json format .
 
    curl "https://api.github.com/repos/khannashiv/Kubernetes-Practice/commits?per_page=30&page=1"
    curl "https://api.github.com/repos/khannashiv/Kubernetes-Practice/commits?per_page=30&page=2"
    curl "https://api.github.com/repos/khannashiv/Kubernetes-Practice/commits?per_page=30&page=3"

    ## We can print maximum 100 items/commits in single page.

    curl "https://api.github.com/repos/khannashiv/Kubernetes-Practice/commits?per_page=100&page=1"
    curl "https://api.github.com/repos/khannashiv/Kubernetes-Practice/commits?per_page=500" --- > But it accepting max of 100 commits as written in official documentation.

    ## In the below command, we are silently taking an output of curl and saving the output in comit.json file & eventually calculating the count of commits made by owner of repo.
    curl -s https://api.github.com/repos/khannashiv/Kubernetes-Practice/commits -o commit.json && jq '.[] | .commit.author.name' commit.json | wc -l

    -->