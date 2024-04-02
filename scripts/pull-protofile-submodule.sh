#!/usr/bin/env bash

# This script is used to setup the submodule for the proto files.
# The script is expected to be run from the root of the repository.

# The script will:
# 1. Clone the proto submodule if it doesn't exist.
# 2. Update the submodule to the latest commit.
# 3. Pull the latest changes if the local branch is behind the remote.

# Exit codes:
# 0 - Successfully updated the submodule
# 1 - Error

set -e

GIT_ROOT=$(git rev-parse --show-toplevel)

# The directory where the proto submodule is cloned to.
PROTO_SUBMODULE_DIR="proto-submodule"

# The URL of the proto submodule.
PROTO_SUBMODULE_URL="https://github.com/mjpowersjr/cicd-test-protos"

# The commit hash or tag of the proto submodule.
PROTO_SUBMODULE_COMMIT="main"

# The directory where the proto files are copied to.
PROTO_DIR="proto"

# cd to git root
cd "${GIT_ROOT}"

# setup the proto submodule if it doesn't exist
if [ ! -d "${PROTO_SUBMODULE_DIR}" ]; then
  echo "Cloning proto submodule..."
  git submodule add --force "${PROTO_SUBMODULE_URL}" "${PROTO_SUBMODULE_DIR}"
  exit 0
fi

# update the proto submodule to the latest commit
cd "${PROTO_SUBMODULE_DIR}"
git fetch --quiet origin

# Get the current branch name
branch=$(git rev-parse --abbrev-ref HEAD)

# Get the number of commits behind the remote
behind=$(git rev-list --count $branch..origin/$branch)


# Print the results
if [ "$behind" -gt 0 ]; then
  echo "Your local branch is $behind commits behind the remote. Updating..."
  git checkout --quiet "${PROTO_SUBMODULE_COMMIT}" > /dev/null
  git pull --quiet
  exit 0
else
  echo "Your local branch is up to date with the remote."
  exit 0
fi
