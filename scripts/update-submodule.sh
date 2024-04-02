#!/bin/bash

# Display usage if not enough arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <submodule_path> <submodule_url> <commit/tag/HEAD>"
    exit 1
fi

SUBMODULE_PATH=$1
SUBMODULE_URL=$2
CHECKOUT_TARGET=$3

# Check if the submodule already exists
if [ -d "$SUBMODULE_PATH/.git" ]; then
    echo "Submodule at $SUBMODULE_PATH already exists."
else
    # Add the submodule if it doesn't exist
    git submodule add $SUBMODULE_URL $SUBMODULE_PATH
    if [ $? -ne 0 ]; then
        echo "Failed to add submodule."
        exit 1
    fi
fi

# Move to the submodule directory
cd $SUBMODULE_PATH || exit

# Fetch latest changes from the remote
git fetch

# Checkout to the specified commit, tag, or HEAD
git checkout $CHECKOUT_TARGET
if [ $? -ne 0 ]; then
    echo "Failed to checkout $CHECKOUT_TARGET."
    exit 1
fi

# Optionally, update the main repository to track the current state of the submodule
cd ..
git add $SUBMODULE_PATH
git commit -m "Updated submodule $SUBMODULE_PATH to $CHECKOUT_TARGET"

echo "Submodule $SUBMODULE_PATH updated and checked out to $CHECKOUT_TARGET successfully."
