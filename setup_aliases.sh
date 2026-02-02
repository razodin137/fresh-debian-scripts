#!/bin/bash

# Define the aliases content
ALIASES_CONTENT='
# --- Custom Git Aliases ---

# Create a new public GitHub repository with the name of the current directory (or provided name), initializing git first
gnew() {
    local repo_name="${1:-$(basename "$PWD")}"
    echo "Creating public repository on GitHub: $repo_name"

    # Initialize git if needed
    if [ ! -d .git ]; then
        git init
        git branch -M master
    fi

    # Ensure we are on master (or use the current branch if you prefer, but script forced master)
    # The original script forced master, so we keep that consistent, but safe-guard against errors.
    # git branch -M master

    git add .
    
    # Check if there are commits, if not commit.
    if ! git diff --cached --quiet; then
        git commit -m "Initial commit" || echo "Nothing to commit"
    fi

    # Create repo on GitHub
    # We use --source=. to let gh handle the remote addition and pushing if possible, 
    # but the original script did it manually-ish to ensure remote is origin.
    # gh repo create handles adding remote if we pass --source=. and --remote=origin.
    
    if gh repo create "$repo_name" --public --source=. --remote=origin; then
        echo "Repository created successfully."
    else
        echo "Failed to create repository (it might already exist)."
    fi

    git push -u origin master
}

# Create a new private GitHub repository with the name of the current directory (or provided name), initializing git first
gnew-p() {
    local repo_name="${1:-$(basename "$PWD")}"
    echo "Creating private repository on GitHub: $repo_name"

    if [ ! -d .git ]; then
        git init
        git branch -M master
    fi

    git add .
    if ! git diff --cached --quiet; then
        git commit -m "Initial commit" || echo "Nothing to commit"
    fi

    if gh repo create "$repo_name" --private --source=. --remote=origin; then
        echo "Repository created successfully."
    else
        echo "Failed to create repository."
    fi

    git push -u origin master
}

# Link current directory to an existing GitHub repo and sync
gconnect() {
    # 1. Fetch your repos and select one using fzf
    # FIX: Used --jq .[].nameWithOwner to avoid quote escaping issues
    local selected_repo=$(gh repo list --limit 1000 --json nameWithOwner --jq ".[].nameWithOwner" | fzf --height 40% --layout=reverse --border --prompt="Select repo to link: ")

    if [ -z "$selected_repo" ]; then
        echo "No repo selected."
        return 1
    fi

    # 2. Initialize git if not already a repo
    [ ! -d .git ] && git init

    # 3. Add or update the remote origin
    git remote remove origin 2>/dev/null || true
    git remote add origin "https://github.com/$selected_repo.git"

    # 4. Get the default branch name
    local default_branch=$(gh repo view "$selected_repo" --json defaultBranchRef --jq .defaultBranchRef.name)
    local is_empty=false
    
    if [ -z "$default_branch" ]; then
        echo "Repo appears to be empty (no default branch)."
        default_branch="master"
        is_empty=true
    fi

    # 5. Sync: Pull remote changes first if not empty
    if [ "$is_empty" = false ]; then
        echo "Syncing with $selected_repo..."
        if ! git pull origin "$default_branch" --rebase --allow-unrelated-histories; then
             echo "Pull failed. If this is a new repo, check if it is truly empty."
             # Continue to allow push attempt if user wants? No, better warn.
        fi
    else
        echo "Skipping pull for empty repository."
    fi

    # 6. Add, Commit, and Push your new files
    git add .
    if ! git diff --cached --quiet; then
        git commit -m "Update from gconnect"
        git push -u origin "$default_branch"
        echo "Successfully linked and pushed!"
    else
        # If we didn"t commit anything, we might still need to push existing commits (if any) or existing files.
        # But if diff cached quiet, it means nothing staged.
        # If the user has local commits that aren"t pushed yet, we should push them.
        echo "No new changes to commit."
        if [ "$is_empty" = true ]; then
             echo "Pushing to empty repo..."
             git push -u origin "$default_branch"
        else
             echo "Pushing any local commits..."
             git push -u origin "$default_branch"
        fi
        echo "Done."
    fi
}
# --------------------------
'

# Check if gnew function already exists in .bashrc
if grep -q "gnew()" ~/.bashrc; then
    echo "It looks like 'gnew' is already defined in ~/.bashrc."
    read -p "Do you want to append the aliases anyway? (y/N): " choice
    case "$choice" in
        y|Y ) echo "Appending aliases to ~/.bashrc...";;
        * ) echo "Skipping."; exit 0;;
    esac
fi

# Append to .bashrc
echo "$ALIASES_CONTENT" >> ~/.bashrc
echo "Aliases successfully added to ~/.bashrc!"
echo "Please run 'source ~/.bashrc' or restart your terminal to use them."
