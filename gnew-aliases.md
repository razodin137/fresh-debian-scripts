
# gnew and gnew-p

Simply nano ~/.bashrc 

and copy-paste this into the bottom of the file to get some helpful Github creation commands.

These commands will look at the name of your current directory, 
create a new repo and push it straight to Github via the gh command line tool (if you're already authenticated).

---

# gconnect

gconnect is for those times when you've started work on something, and you want to add it to a repo you already made. 

The "gconnect" command will sync your current directory with an existing repo.

Simply run the command, search the name of your repo, and automatically sync the changes in the current directory. 

```bash
# Create a new public GitHub repository with the name of the current directory, initializing git first
gnew() {
    git init && \
    git branch -M master && \
    git add . && \
    git commit -m "Initial commit" && \
    gh repo create "$(basename "$PWD")" --public --source=. --remote=origin && \
    git push -u origin master
}

# Create a new private GitHub repository with the name of the current directory, initializing git first
gnew-p() {
    git init && \
    git branch -M master && \
    git add . && \
    git commit -m "Initial commit" && \
    gh repo create "$(basename "$PWD")" --private --source=. --remote=origin && \
    git push -u origin master
}

# Link current directory to an existing GitHub repo and sync
gconnect() {
    # 1. Fetch your repos and select one using fzf
    local selected_repo=$(gh repo list --limit 1000 --json nameWithOwner --template '{{range .}}{{ .nameWithOwner }}{{"\n"}}{{end}}' | fzf --height 40% --layout=reverse --border --prompt="Select repo to link: ")

    if [ -z "$selected_repo" ]; then
        echo "No repo selected."
        return 1
    fi

    # 2. Initialize git if not already a repo
    [ ! -d .git ] && git init

    # 3. Add or update the remote 'origin'
    git remote add origin "https://github.com/$selected_repo.git" 2>/dev/null || \
    git remote set-url origin "https://github.com/$selected_repo.git"

    # 4. Get the default branch name
    local default_branch=$(gh repo view "$selected_repo" --json defaultBranchRef --jq .defaultBranchRef.name)
    [ -z "$default_branch" ] && default_branch="master"

    # 5. Sync: Pull remote changes first
    echo "Syncing with $selected_repo..."
    git pull origin "$default_branch" --rebase --allow-unrelated-histories

    # 6. Add, Commit, and Push your new files
    git add .
    if ! git diff --cached --quiet; then
        git commit -m "Update from gconnect"
        git push -u origin "$default_branch"
        echo "Successfully synced and pushed!"
    else
        echo "No new changes to push, but repo is now linked."
    fi
}
```