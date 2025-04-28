#!/usr/bin/env bash

# @Author: Dr. Jeffrey Chijioke-Uche 
# @Date: 2023-10-01
# @Last Modified by: Dr. Jeffrey Chijioke-Uche
# @Last Modified time: 2025-04-27
# -----------------------------------------------------------------------------
#   Commit Code Update to Github
# -----------------------------------------------------------------------------
set -euo pipefail

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
RESET='\033[0m'

#-------------------------------------------------------------------------------
# Utility banner
#--------------------------------------------------------------------------------
banner() {
  local color=$1
  local msg=$2
  echo -e "${color}===================================================================================================${RESET}"
  echo -e "${color}» ${msg}${RESET}"
  echo -e "${color}===================================================================================================${RESET}"
}

#-------------------------------------------------------------------------------
# Function to check if the script is run from the root directory of the repository
# and if there are any changes to commit
# and if the user is on the main branch
# This function is called at the beginning of the script
# to ensure that the script is run in the correct context
#-------------------------------------------------------------------------------
change_management() {
  # Check if the script is run from the root directory of the repository
  banner "${YELLOW}" "🔍 Checking if script is run from the root directory of the repository..."
  if [ ! -d ".git" ]; then
    echo -e "${RED}⛔ This script must be run from the root directory of a Git repository.${RESET}"
    exit 1
   else
     echo -e "${GREEN}✅ Script is run from the root directory of the repository.${RESET}"
  fi

  # Check if there are any changes to commit
  banner "${GREEN}" "🔍 Checking for changes to commit..."
  if [ -z "$(git status --porcelain)" ]; then
    echo -e "${YELLOW}⚠️ No changes to commit.${RESET}"
    exit 0
    else
      echo -e "${GREEN}✅ Changes detected.${RESET}"
  fi

  # Check if the user is on the main branch
  banner "${BLUE}" "🔍 Checking current branch..."
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  if [ "$current_branch" != "main" ]; then
    echo -e "${RED}⛔ You must be on the main branch to commit changes.${RESET}"
    exit 1
    else
      echo -e "${GREEN}✅ You are on the main branch.${RESET}"
  fi
}

# -----------------------------------------------------------------------------
commit() {
  # Check if the script is run from the root directory of the repository
  change_management

  # Add all changes to version control
  banner "${YELLOW}" "🧹 Adding code to version control..."
  git add -A
  # Make commit comment with today's date and time
  # and a message
  banner "${GREEN}" "📝 Committing changes..."
  git commit -m "Quantum Code Update - $(date +'%Y-%m-%d %H:%M:%S')"
  # Push to the main branch
  banner "${CYAN}" "🚀 Pushing changes to remote repository..."
  git push origin main
  # Push to Stable branch in remote & stable does not exist locally
  # If stable branch does not exist locally, create it from main
  if ! git show-ref --verify --quiet refs/heads/stable; then
    banner "${YELLOW}" "🔄 Creating stable branch from main..."
    git checkout -b stable
  else
    banner "${YELLOW}" "🔄 Switching to stable branch..."
    git checkout stable
  fi
  # Merge main to the stable branch & this is the branch that will be used for the stable version
  banner "${MAGENTA}" "🔄 Merging main into stable branch..."
  git merge main
  # Push to the stable branch
  banner "${GREEN}" "🚀 Pushing changes to stable branch..."
  git push origin stable
  # Switch back to main branch
  banner "${YELLOW}" "🔄 Switching back to main branch..."
  git checkout main
}
commit
# -----------------------------------------------------------------------------
#   End of Commit Code Update to Github
# -----------------------------------------------------------------------------