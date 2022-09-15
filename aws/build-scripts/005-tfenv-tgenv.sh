#!/usr/bin/env bash 
# shellcheck source=/dev/null
set -echo

build_scripts_dir=$(dirname "$(readlink -f "$0")")
source "$build_scripts_dir"/common.sh

if [[ ! -d ~/.tfenv ]]; then git clone https://github.com/tfutils/tfenv.git ~/.tfenv; fi
# this is a public git library, check before use 
if [[ ! -d ~/.tgenv ]]; then git clone https://github.com/cunymattieu/tgenv.git ~/.tgenv; fi

cp -f .terraform-version ~ && cp -f .terragrunt-version ~
tfenv install
tgenv install
