#!/usr/bin/env bash
set -x

export SSHURL=github.com

if [ -z "$1" ]; then
    echo "No environment argument supplied"
    exit 1
fi

export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
export TERRAGRUNT_DOWNLOAD="$HOME/.terragrunt-cache"
if [[ -f "$TF_PLUGIN_CACHE_DIR " ]]; then rm -rf "$TF_PLUGIN_CACHE_DIR"; fi
if [[ -f "$TERRAGRUNT_DOWNLOAD " ]]; then rm -rf "$TERRAGRUNT_DOWNLOAD"; fi
mkdir -p "$TF_PLUGIN_CACHE_DIR" && mkdir -p "$TERRAGRUNT_DOWNLOAD"

cat >"$HOME/.terraformrc" <<EOF
plugin_cache_dir = "$TF_PLUGIN_CACHE_DIR"
EOF

if [[ -f ~/.ssh/known_hosts ]]; then ssh-keygen -R "${SSHURL}" >/dev/null; fi
ssh-keyscan -H "${SSHURL}" >>~/.ssh/known_hosts 2>/dev/null

retVal=0
env_root="${WORKSPACE}/terragrunt/$1"

cd "$env_root" || exit
shopt -s globstar
for d in "$(pwd)"/**/*; do
    echo "$d"
    # change to path of own database in staging 
    if [[ $d == *"terragrunt/staging/maindb" ]]; then 
        continue 
    fi
    if [[ -d "$d" && -f "$d/terragrunt.hcl" ]]; then 
        cd "$d" || exit
        TF_SKIP_PROVIDER_VERIFY=1 TF_IAM_ROLE=TerraformReadWriteRole terragrunt plan \
            --terragrunt-source-update \
            --terragrunt-non-interactive \
            -lock-timeout=5m \
            -detailed-exitcode \
            -out="$d/plan.out" \
            -input=false
        retVal=$?
        if [[ -f "plan.out" && retVal -eq 2 ]]; then
            stack="$(basename "$(dirname"$(pwd)")")/$(basename "(pwd)")"
            echo "## Applying changes for ${stack}"
            TF_SKIP_PROVIDER_VERIFY=1 TF_IAM_ROLE=TerraformReadWriteRole terragrunt apply \
                --terragurnt-source-update \
                --terragrunt-non-interactive \
                -lock-timeout=5m \
                -input=false \ 
                plan.out
            retVal=$?
        fi
        if [[ retVal -ne 0 ]]; then 
            exit $retVal
        fi
    fi
done
