#!/usr/bin/env bash

# @Author: Dr. Jeffrey Chijioke-Uche, Computer Scientist
# @Date: 2023-10-01
# @Last Modified by: Dr. Jeffrey Chijioke-Uche
# @Last Modified time: 2023-10-01
# @Description: This script checks for prohibited tags and validates semantic versioning.
# @Copyright: 2025 Dr. Jeffrey Chijioke-Uche, Qiskit Connector Intelligence Core.
# @License: Apache-2.0 | Creative Commons Attribution-NonCommercial 4.0 International
###################################################################################

PROHIBITED=(main prod stable dev qa test bug pypi release snapshot nightly)
VALID_TAGS=()

echo "🔍 Fetching tags..."
git fetch --tags

for TAG in $(git tag); do
  # Check prohibited
  for p in "${PROHIBITED[@]}"; do
    if [[ "$TAG" == *"$p"* ]]; then
      echo "❌ Prohibited tag found: $TAG"
      git push origin :refs/tags/"$TAG"
      continue 2
    fi
  done

  # Check semantic format
  if [[ "$TAG" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-rc[0-9]{2})?$ ]]; then
    VALID_TAGS+=("$TAG")
  else
    echo "❌ Invalid tag format: $TAG"
    git push origin :refs/tags/"$TAG"
  fi
done

# Create releases for valid tags
for VALID in "${VALID_TAGS[@]}"; do
  echo "✅ Creating release for $VALID"
  # ... use curl or gh CLI to create release
done
