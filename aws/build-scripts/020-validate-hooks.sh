#!/usr/bin/env bash
# shellcheck source=/dev/null
set -e
build_scripts_dir=$(dirname "$(readlink -f "$0")")
source "$build_scripts_dir"/common.sh

pre-commit install -f
pre-commit run -a
