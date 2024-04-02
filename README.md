# cicd-test-sdk

## Automated Release Workflows
### Upstream .proto changes
1. Checkout the latest protos submodule commit
2. If we are behind, update the submodule and run *Generate Code* workflow.

### Generate code
1. Run code generation based on protos submodule.
2. If there are changes, commit to main. Run *Versioning* workflow.

### Versioning
1. If we have any local commits, bump version number
2. Publish new release
