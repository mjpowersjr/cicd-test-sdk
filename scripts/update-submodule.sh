#!/bin/bash

# Display usage if not enough arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <submodule_path> <submodule_url> <commit/tag/HEAD>"
    exit 1
fi

SUBMODULE_PATH=$1
SUBMODULE_URL=$2
CHECKOUT_TARGET=$3

GIT_ROOT=$(git rev-parse --show-toplevel)

# Check if the submodule already exists
if [ -d "$SUBMODULE_PATH/.git" ]; then
    echo "Submodule at $SUBMODULE_PATH already exists."
else
    echo "Adding submodule at $SUBMODULE_PATH..."
    # Add the submodule if it doesn't exist
    git submodule add --force $SUBMODULE_URL $SUBMODULE_PATH
    if [ $? -ne 0 ]; then
        echo "Failed to add submodule."
        exit 1
    fi
fi

# Move to the submodule directory
cd $SUBMODULE_PATH > /dev/null || exit

# Fetch latest changes from the remote
echo "Fetching latest changes from the remote..."
git fetch --quiet

# Checkout to the specified commit, tag, or HEAD
echo "Checking out to $CHECKOUT_TARGET..."
git checkout --quiet $CHECKOUT_TARGET
if [ $? -ne 0 ]; then
    echo "Failed to checkout $CHECKOUT_TARGET."
    exit 1
fi

# Optionally, update the main repository to track the current state of the submodule
cd $GIT_ROOT > /dev/null || exit
git add $SUBMODULE_PATH
git commit -m "Updated submodule $SUBMODULE_PATH to $CHECKOUT_TARGET"

echo "Submodule $SUBMODULE_PATH updated and checked out to $CHECKOUT_TARGET successfully."
