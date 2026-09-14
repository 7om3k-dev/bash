#!/bin/bash

current_version=$(kubectl version | grep -w 'Client Version:' | cut -d : -f 2 | tr -d ' ')

echo enter version to update kubectl to: && read new_version
new_version="v$new_version"

if [[ $current_version != $new_version ]]; then
    echo "installed version is ($current_version) version to update to is ($new_version). Versions does not match, fetching new kubctl version..."

    curl -LO "https://dl.k8s.io/release/$(echo $new_version)/bin/darwin/arm64/kubectl"
    curl -LO "https://dl.k8s.io/release/$(echo $new_version)/bin/darwin/arm64/kubectl.sha256"

    checksum_status=$(echo "$(cat kubectl.sha256)  kubectl" | shasum -a 256 --check)

    if [[ $checksum_status == "kubectl: OK" ]]; then
      echo "cheksum validation successful! Updating kubctl..."

      chmod u+x ./kubectl

      mkdir -p ~/bin && mv ./kubectl ~/bin
      rm kubectl.sha256

      echo "Update successful!"
      exit 0
    else
      echo "cheksum validation failed! Terminating script"
      exit 1
    fi
else
    echo "installed kubctl version is: ($current_version) version to update to is: ($new_version). Versions match, no update will be performed."
fi
