#!/usr/bin/env bash
set -e

echo "Running Build Scripts"
cd "${WORKSPACE}"

if [ ! -d "build-scripts" ]; then
    echo "Directory build-scripts DOES NOT exist."
    exit 1
fi

for i in build-scripts/*.sh; do 
    if [[ ${i} = build-scripts/[0-9]* ]]; then
        echo "Running: ${i}"
        ./"$i"
    fi
done
