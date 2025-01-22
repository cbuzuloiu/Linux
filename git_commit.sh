#!/bin/bash

# Bash script to commit and push changes to Git with user interaction and red-colored messages

# Function to display text in red
red_echo() {
  echo -e "\033[31m$1\033[0m"
}

red_echo "Starting Git commit process..."

# Add all changes to the staging area
git add .
red_echo "All changes added to the staging area."

# Show the status of the repository
git status

# Ask the user if they want to continue
read -p "$(red_echo 'Do you want to continue? (y/n): ')" proceed
if [[ $proceed != "y" ]]; then
  red_echo "Aborting Git commit process."
  exit 1
fi

# Get commit message from the user
read -p "$(red_echo 'Enter commit message: ')" commit_message

# Commit changes with the user-provided message
git commit -m "$commit_message"

# Push changes to the 'main' branch on the remote repository
red_echo "Pushing changes to the 'main' branch..."
git push -u origin main

red_echo "Git commit process completed."
