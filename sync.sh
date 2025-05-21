#!/usr/bin/env bash
#_____________________________________________________________________________
# @Author: Dr. Jeffrey Chijioke-Uche, IBM
# @Date: 2023-10-03
# @Last Modified by:   Dr. Jeffrey Chijioke-Uche
# @Last Modified time: 2025-05-04
# @Description: This script automates the release process for a Python Pypi package.
# @License: Apache License 2.0
# @Version Pattern:  major.minor.patch (x.y.z)
# @Version Bump Logic: patch: 0→9, then bump minor; minor: 0→90, then bump major
# @Semantic Versioning: https://semver.org/
#_________________________________________________________________________________

set -euo pipefail
git pull
source ./pvars.sh


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

banner() {
  local color=$1 msg=$2
  echo -e "${color}========================================${RESET}"
  echo -e "${color}» ${msg}${RESET}"
  echo -e "${color}========================================${RESET}"
}

# -----------------------------------------------------------------------------
# Refresh git repository
# -----------------------------------------------------------------------------
git pull origin main
git fetch --all

# -----------------------------------------------------------------------------
# Bump version in a file: setup.py or pyproject.toml
# -----------------------------------------------------------------------------
bump_version() {
  local file="$1"

  local line ver major minor patch
  line=$(grep -m1 -E 'version\s*=\s*"[0-9]+\.[0-9]+\.[0-9]+"' "$file") || {
    echo -e "${RED}⛔ Could not find a version line in ${file}.${RESET}"
    exit 1
  }

  ver=$(sed -E 's/.*version\s*=\s*"([0-9]+\.[0-9]+\.[0-9]+)".*/\1/' <<<"$line")
  IFS='.' read -r major minor patch <<<"$ver"

  # New bump logic: patch: 0→9, then reset & bump minor; minor: 0→90, then bump major
  if (( patch < 9 )); then
    patch=$((patch + 1))
  else
    patch=0
    if (( minor < 90 )); then
      minor=$((minor + 1))
    else
      minor=0
      major=$((major + 1))
    fi
  fi

  local new_version="${major}.${minor}.${patch}"

  # In-place replace (Linux & macOS)
  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' -E "s/version\s*=\s*\"[0-9]+\.[0-9]+\.[0-9]+\"/version = \"${new_version}\"/" "$file"
  else
    sed -i -E "s/version\s*=\s*\"[0-9]+\.[0-9]+\.[0-9]+\"/version = \"${new_version}\"/" "$file"
  fi

  echo -e "${GREEN}🔖 Bumped ${file} → version ${new_version}${RESET}"
}

# -----------------------------------------------------------------------------
# Bump version in CITATION.bib
# -----------------------------------------------------------------------------
bump_version_citation() {
    local file="CITATION.bib"

    if [[ ! -f "$file" ]]; then
      echo -e "${YELLOW}⚠️ Skipping CITATION.bib — file not found.${RESET}"
      return
    fi

    local line version major minor patch
    line=$(grep -m1 -E 'version\s*=\s*\{[0-9]+\.[0-9]+\.[0-9]+\}' "$file") || {
      echo -e "${RED}⛔ No version entry found in ${file}.${RESET}"
      return
    }

    version=$(sed -E 's/.*version\s*=\s*\{([0-9]+\.[0-9]+\.[0-9]+)\}.*/\1/' <<<"$line")
    IFS='.' read -r major minor patch <<<"$version"

    if (( patch < 9 )); then
      patch=$((patch + 1))
    else
      patch=0
      if (( minor < 90 )); then
        minor=$((minor + 1))
      else
        minor=0
        major=$((major + 1))
      fi
    fi

    new_version="${major}.${minor}.${patch}"

    # Use sed to update the version
    if [[ "$OSTYPE" == "darwin"* ]]; then
      sed -i '' -E "s/version\s*=\s*\{[0-9]+\.[0-9]+\.[0-9]+\}/version = \{${new_version}\}/" "$file"
    else
      sed -i -E "s/version\s*=\s*\{[0-9]+\.[0-9]+\.[0-9]+\}/version = \{${new_version}\}/" "$file"
    fi

    echo -e "${GREEN}🔖 Bumped CITATION.bib → version ${new_version}${RESET}"
}


# -----------------------------------------------------------------------------
# Main release::   DEACTIVATED
# -----------------------------------------------------------------------------
release() {
  # 0) Clean up old distributions
  banner "${YELLOW}" "🧹 Cleaning up old distributions..."
  rm -rf dist/*
  echo -e "${YELLOW}Done.${RESET}" && sleep 2

  # 1) Version bump
  banner "${CYAN}" "📝 Bumping versions..."
  bump_version setup.py
  bump_version pyproject.toml
  bump_version_citation
  sleep 2

  # 2) Build distributions
  banner "${CYAN}" "🛠️  Building distribution..."
  echo "🔍 Checking for Python 'build' module..."
  if python3 -m pip show build > /dev/null 2>&1; then
    echo "✅ Python 'build' module exists."
  else
    echo "⚠️ 'build' module not found. Installing..."
    python3 -m pip install --upgrade build || {
      echo "❌ Failed to install 'build'."
      exit 1
    }
  fi
  python3 -m build
  sleep 2

  # 3) Check distributions
  banner "${YELLOW}" "🔍 Checking distributions..."
  twine check dist/*
  sleep 2

  # 4) Release to PyPI (via Trusted Publisher)
  banner "${MAGENTA}" "📤 Releasing new version to PyPI..."
  echo -e "${YELLOW}Please wait...${RESET}"
  # Delegate to trusted publisher actions: Never Allow twine to be run locally
  # twine upload --skip-existing dist/* || {}
  echo -e "${RED}⛔ Twine release is disabled for local execution.${RESET}"
  echo -e "${RED}🔔 Trusted publisher workflow will now release.${RESET}"
  sleep 2

  echo -e "${GREEN}🔔 Release process has been initiated by trusted publisher.${RESET}"
}


#=================================================
# Update stable branch: DEACTIVATED
#=================================================
update_stable_branch() {
  # Check if the stable branch exists
  banner "${BLUE}" "🔄 Updating stable branch..."
  if git show-ref --verify --quiet refs/heads/stable; then
    echo -e "${GREEN}✅ Stable branch exists.${RESET}"
    git checkout stable
    git pull origin stable
  else
    echo -e "${YELLOW}⚠️ Stable branch not found; creating...${RESET}"
    git checkout -b stable
    git pull origin stable || true
  fi

  # Merge main into stable and push changes
  git merge main --no-edit
  git push origin stable
  git checkout main
  git pull
}


# -----------------------------------------------------------------------------
#  statuses
main_release_status="off"
update_stable_branch_status="off"
citation_status="on"
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# RELEASE SYNCHRONIZATION
# -----------------------------------------------------------------------------
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

  if [[ "$main_release_status" == "on" ]]; then
    echo "Starting release process..." 
    release
  else
    echo "Release process is not enabled." 
    echo "We are proceeding with synchronization only."
  fi


  if [[ "$citation_status" == "on" ]]; then
    echo -e "${GREEN}🔖 Bumping CITATION.bib version...${RESET}"
    bump_version_citation
    git pull
  else
    echo -e "${YELLOW}⚠️ Skipping CITATION.bib version bump.${RESET}"
  fi


  if [[ "$update_stable_branch_status" == "off" ]]; then
    echo -e "${RED}⛔ Skipping stable branch update.${RESET}"
  else
    echo -e "${GREEN}✅ Stable branch update in progress...${RESET}"
    update_stable_branch
  fi


#-------------------------------------------------------------------------------------------------
  banner "${BLUE}" "💾 Committing & pushing sync..."
  git add -A
  git commit -S --gpg-sign="$GPG_KEY_ID" -m "Release $(grep -m1 -E 'version\s*=\s*\"' CITATION.bib |
                      sed -E 's/.*\"([0-9]+\.[0-9]+\.[0-9]+)\".*/\1/')"
  echo "Release Signed & Synced."
  git push
  git pull

  echo "Please wait while we synchronize with GitHub..."
  sleep 15
  banner "${GREEN}" "🎉 Release process complete!"
fi


# -----------------------------------------------------------------------------
# Synchronize with GitHub
# -----------------------------------------------------------------------------
banner "${YELLOW}" "🔄 Synchronization complete!"
exit 0
#--------------------------------------------------------------------------
# End of script
#--------------------------------------------------------------------------