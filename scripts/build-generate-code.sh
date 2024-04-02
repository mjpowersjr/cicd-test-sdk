#!/usr/bin/env bash

set -e

SCRIPTS_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
PACKAGE_ROOT=$(dirname "${SCRIPTS_ROOT}")
GIT_ROOT=$(git rev-parse --show-toplevel)

# Path to Protoc Plugin
PLUGIN_PATH="${GIT_ROOT}/node_modules/.bin/protoc-gen-ts_proto"

# Accept INPUT / OUTPUT directories as arguments
SRC_DIR=$1
OUT_DIR=$2

# provide usage statement if not enough arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_directory> <output_directory>"
    exit 1
fi

# If the input directory does not exist, exit
if [ ! -d "${SRC_DIR}" ]; then
    echo "Input directory does not exist: ${SRC_DIR}"
    exit 1
fi

# If the output directory does not exist, create it
if [ ! -d "${OUT_DIR}" ]; then
    mkdir -p "${OUT_DIR}"
fi

# Change to the directory holding all .proto files
pushd "${SRC_DIR}" > /dev/null

echo "Generating TypeScript files from .proto files..."
# Generate all messages
protoc \
    --plugin=${PLUGIN_PATH} \
    --ts_proto_opt=addGrpcMetadata=true \
    --ts_proto_opt=env=node \
    --ts_proto_opt=exportCommonSymbols=false \
    --ts_proto_opt=forceLong=bigint \
    --ts_proto_opt=outputIndex=true \
    --ts_proto_opt=outputServices=grpc-js \
    --ts_proto_opt=stringEnums=true \
    --ts_proto_out=${OUT_DIR} \
    $(find . -name "*.proto")

echo "Finished generating TypeScript files from .proto files."
