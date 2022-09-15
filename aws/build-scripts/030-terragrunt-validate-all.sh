#!/usr/bin/env bash
# shellcheck source=/dev/null
set -e

build_scripts_dir=$(dirname "$(readlink -f "$0")")
source "$build_scripts_dir"/common.sh

cd "${WORKSPACE}/terragrunt/dev/"
terragrunt graph-dependencies

cd "${WORKSPACE}/terragrunt/staging/"
terragrunt graph-dependencies

cd "${WORKSPACE}/terragrunt/prod/"
terragrunt graph dependencies
