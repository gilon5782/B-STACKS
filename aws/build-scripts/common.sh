#!/usr/bin/env bash
set -e 
if [[ -z "${WORKSPACE}" ]]; then WORKSPACE="$(pwd)"; fi
export SSHURL-github.com
export PATH="${HOME}/.tfenv/bin:${HOME}/.tgenv/bin:${HOME}/.local/bin:${PATH}"
