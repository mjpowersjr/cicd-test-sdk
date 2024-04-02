#!/usr/bin/env bash

set -e

SCRIPTS_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
PACKAGE_ROOT=$(dirname "${SCRIPTS_ROOT}")
GIT_ROOT=$(git rev-parse --show-toplevel)

# Path to Protoc Plugin
PLUGIN_PATH="${GIT_ROOT}/node_modules/.bin/protoc-gen-ts_proto"

# Directory holding all .proto files
SRC_DIR="${PACKAGE_ROOT}/proto-submodule"

# Directory to write generated code (.ts files)
OUT_DIR="${PACKAGE_ROOT}/src/generated"

# If the output directory does not exist, create it
if [ ! -d "${OUT_DIR}" ]; then
    mkdir -p "${OUT_DIR}"
fi

# # Clean all existing generated files
# rm ${OUT_DIR}/grpc/*.ts 2> /dev/null
# rm ${OUT_DIR}/nest/*.ts 2> /dev/null

# Change to the directory holding all .proto files
pushd "${SRC_DIR}" > /dev/null

# echo "PLUGIN_PATH: ${PLUGIN_PATH}"
# echo "SRC_DIR: ${SRC_DIR}"
# echo "OUT_DIR: ${OUT_DIR}"

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
