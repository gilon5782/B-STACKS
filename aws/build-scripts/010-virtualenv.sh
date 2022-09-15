#!/usr/bin/env bash
# shellcheck source=/dev/null

build_scripts_dir=$(dirname "$(readlink -f "$0")")
source "$build_scripts_dir"/common.sh

if ! command -v python3; then exit 1; fi
if ! command -v pipx; then python3 -m pip install --user pipx; python3 -m pipx ensurepath; fi
if ! command -v pre-commit; then pipx install pre-commit; fi
