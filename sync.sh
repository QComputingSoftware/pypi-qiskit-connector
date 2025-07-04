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
#_____________________________________________________________________________

set -euo pipefail

# Get the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PVARS="$SCRIPT_DIR/pvars.sh"
if [[ ! -f "$PVARS" ]]; then
  echo "Warning: pvars may not be available from your location."
else
  echo "PVARS sourced successfully."
  source "$PVARS"
fi

# Git operations
git pull --no-edit
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
# Bump version in setup.py or pyproject.toml
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


#=================================================
# Sync Pad:
#=================================================
syncpad(){
  #set -x
  git add -A
  VERSION=$(grep -m1 -E 'version\s*=\s*\{[0-9]+\.[0-9]+\.[0-9]+\}' CITATION.bib | sed -E 's/.*\{([0-9]+\.[0-9]+\.[0-9]+)\}.*/\1/')
  if [[ -z "${VERSION}" ]]; then
    echo "❌ Could not extract version from CITATION.bib! Check the file format."
    exit 1
  fi

  # if [[ -z "${GPG_KEY_ID:-}" ]]; then
  #   echo "❌ GPG_KEY_ID not set! Commit will fail."
  # else
  #   MASKED_KEY=$(printf '%*s' "${#GPG_KEY_ID}" | tr ' ' 'X')
  #   echo "Using GPG_KEY_ID: $MASKED_KEY"
  # fi

  git commit -S --gpg-sign="$GPG_KEY_ID" -m "Release $VERSION" 
  git push origin main
  echo "Release Signed & Synced."
  git pull
  echo "Please wait while we synchronize with GitHub..."
  sleep 15
  banner "${GREEN}" "🎉 Release process complete!"
  set +x
}



# -----------------------------------------------------------------------------
# RELEASE SYNCHRONIZATION
# -----------------------------------------------------------------------------
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

  # Default control variables to "on" if not set
  main_release_status="${main_release_status:-on}"
  citation_status="${citation_status:-on}"
  update_stable_branch_status="${update_stable_branch_status:-on}"
  sync_status="${sync_status:-on}"

  # Show all current statuses for debug
  echo -e "${CYAN}Current main_release_status: $main_release_status${RESET}"
  echo -e "${CYAN}Current citation_status: $citation_status${RESET}"
  echo -e "${CYAN}Current update_stable_branch_status: $update_stable_branch_status${RESET}"
  echo -e "${CYAN}Current sync_status: $sync_status${RESET}"

  # # MAIN RELEASE PROCESS
  # if [[ "$main_release_status" == "off" ]]; then
  #   echo -e "${YELLOW}⛔ Skipping main release process.${RESET}"
  #   echo "We are proceeding with synchronization only."
  # else
  #   echo -e "${GREEN}🔖 Starting main release process...${RESET}"
  #   release
  # fi

  # CITATION VERSION BUMP
  if [[ "$citation_status" == "off" ]]; then
    echo -e "${YELLOW}⛔ Skipping CITATION.bib version bump.${RESET}"
  else
    echo -e "${GREEN}🔖 Bumping CITATION.bib version...${RESET}"
    bump_version_citation
    git pull --no-edit
  fi

  # # STABLE BRANCH UPDATE
  # if [[ "$update_stable_branch_status" == "off" ]]; then
  #   echo -e "${RED}⛔ Skipping stable branch update.${RESET}"
  # else
  #   echo -e "${GREEN}✅ Stable branch update in progress...${RESET}"
  #   update_stable_branch
  # fi

  # SYNCHRONIZATION PAD
  if [[ "$sync_status" == "off" ]]; then
    echo -e "${RED}⛔ Skipping synchronization - Syncpad Disabled.${RESET}"
  else
    echo -e "${GREEN}✅ Syncpad update in progress...${RESET}"
    syncpad
    echo -e "${GREEN}🔄 Syncpad done![D89-00] ${RESET}"
  fi
fi
