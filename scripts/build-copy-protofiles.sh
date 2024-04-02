#!/usr/bin/env bash

SCRIPTS_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
PACKAGE_ROOT=$(dirname "${SCRIPTS_ROOT}")

# make sure the dist directory exists
if [ ! -d "${PACKAGE_ROOT}/dist" ]; then
    mkdir -p "${PACKAGE_ROOT}/dist"
fi

# Copy the proto files to the event-protobuf-models dist directory
cp -r "${PACKAGE_ROOT}/proto-submodule" "${PACKAGE_ROOT}/dist/proto"

# Remove any non-proto files from destination
find "${PACKAGE_ROOT}/dist/proto" -type f ! -name "*.proto" -delete
