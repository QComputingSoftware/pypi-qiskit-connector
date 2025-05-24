#!/usr/bin/env bash

# @Author: Dr. Jeffrey Chijioke-Uche 
# @Date: 2023-10-01
# @Last Modified by: Dr. Jeffrey Chijioke-Uche
# @Last Modified time: 2025-04-27
# Purpose: This script automates patches.
# -----------------------------------------------------------------------------
#   Commit Code Update to Github
# -----------------------------------------------------------------------------
set -euo pipefail
source ./pvars.sh
git fetch


export GPG_TTY=$(tty)
export GPG_AGENT_INFO=$(gpgconf --list-dirs agent-socket)

# -----------------------------------------------------------------------------
#   GPG Configuration for Non-Interactive Signing
# -----------------------------------------------------------------------------
mkdir -p ~/.gnupg
chmod 700 ~/.gnupg
echo "allow-loopback-pinentry" >> ~/.gnupg/gpg.conf
echo "use-agent" >> ~/.gnupg/gpg.conf
echo "pinentry-mode loopback" >> ~/.gnupg/gpg.conf
echo "allow-loopback-pinentry" >> ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
gpgconf --launch gpg-agent

export GPG_TTY=$(tty)
export GIT_COMMITTER_DATE="$(date -R)"


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

# -----------------------------------------------------------------------------
# Refresh git repository
# -----------------------------------------------------------------------------
banner "${GREEN}" "🔄 Pulling latest changes from remote repository..."
git fetch origin
git pull origin main --no-edit
git merge origin/main --allow-unrelated-histories || true
#git pull origin stable --no-edit

#-------------------------------------------------------------------------------
# Function to check if the script is run from the root directory of the repository
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
    git checkout main
    if [ $? -ne 0 ]; then
      echo -e "${RED}⛔ Failed to switch to the main branch. Please resolve any issues and try again.${RESET}"
      exit 1
    fi
    else
      echo -e "${GREEN}✅ You are on the main branch.${RESET}"
  fi
}

# -----------------------------------------------------------------------------
patch() {
  # Check if the script is run from the root directory of the repository
  change_management
  #git pull origin main
  # Add all changes to version control
  banner "${YELLOW}" "🧹 Adding code to version control, please wait..."
  git add -A
  git merge origin/main --allow-unrelated-histories || true
  sleep 5
  echo -e "${GREEN}✅ All changes added to version control successfully.${RESET}"
  banner "${GREEN}" "📝 Signing & Committing changes..."
  git commit -S --gpg-sign="$GPG_KEY_ID" -m "Quantum Connector Update - $(date +'%Y-%m-%d %H:%M:%S')"
  echo -e "${GREEN}✅ Changes signed & committed successfully.${RESET}"
  echo ""
  
  # Push to the main branch
  banner "${CYAN}" "🚀 Pushing changes to remote repository..."
  git push origin main

  #_______________________________________________________________________________________________
  # Merge main to the stable branch & this is the branch that will be used for the stable version
  #_______________________________________________________________________________________________
  # # Push to Stable branch in remote & stable does not exist locally
  # # If stable branch does not exist locally, create it from main
  # if ! git show-ref --verify --quiet refs/heads/stable; then
  #   banner "${YELLOW}" "🔄 Creating stable branch from main..."
  #   git checkout -b stable
  # else
  #   banner "${YELLOW}" "🔄 Switching to stable branch..."
  #   git checkout stable
  #   git pull origin stable
  # fi


  # DISBALED:  ALL PULL REQUESTS TO MERGE INTO ANOTHER BRANCH FROM MAIN MUST BE VIA GITHUB UI
  #_______________________________________________________________________________________________
  # Merge main to the stable branch & this is the branch that will be used for the stable version
  #_______________________________________________________________________________________________
  # banner "${MAGENTA}" "🔄 Merging main into stable branch..."
  # git merge main --no-edit
  # # Check if there are any merge conflicts

  # if [ $? -ne 0 ]; then
  #   echo -e "${RED}⛔ Merge conflicts detected. Please resolve them and try again.${RESET}"
  #   exit 1
  # fi

  # banner "${GREEN}" "🚀 Pushing changes to stable branch..."
  # git push origin stable
  # if [ $? -ne 0 ]; then
  #   echo -e "${RED}⛔ Failed to push changes to the stable branch. Please resolve any issues and try again.${RESET}"
  #   exit 1
  # fi

  # # Switch back to main branch
  # banner "${YELLOW}" "🔄 Switching back to main branch..."
  # git checkout main
  # git pull origin main
  # echo -e "${GREEN}✅ Successfully switched back to main branch.${RESET}"


banner "${GREEN}" "🎉 Release process complete!"
  if [ -n "$(git status --porcelain)" ]; then
    echo -e "${YELLOW}⚠️ You have uncommitted changes in the main branch.${RESET}"
    git commit -S --gpg-sign="$GPG_KEY_ID" -m "Quantum Connector Update - $(date +'%Y-%m-%d %H:%M:%S')"
    git merge origin/main --allow-unrelated-histories || true
    git push origin main
  fi

  banner "${GREEN}" "✅ Successfully committed changes to the main branch."
  banner "${CYAN}" "🚀 Successfully pushed changes to the remote repository."
  banner "${GREEN}" "🔄 Successfully merged main into stable branch."
}



#Call
#----
patch







sleep 3
git pull origin main --no-edit
banner "${GREEN}" "🎉 Patch process complete!"
echo -e "${GREEN}🔄 All operations completed successfully.${RESET}"
# -----------------------------------------------------------------------------
#   End of Commit Code Update to Github
# -----------------------------------------------------------------------------