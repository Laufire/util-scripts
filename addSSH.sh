#!/bin/bash

# Init
cd $(dirname $0)
set -ex
# Data
certID=$1
sshDir=$(realpath ~/.ssh)

# Tasks
addAllCerts() { #ToDo: Fix: git isn't able to handle multiple parallel identities.
  
  find "$sshDir" -iname id_rsa | while read filePath
  do
    ssh-add -k "$filePath"
  done
}

addOneCert() {

  certID=$1
  ssh-add -D
  ssh-add -k "$sshDir/$certID/id_rsa"
}

# Main
eval $(ssh-agent -s)

if [ -z certID ]; then
  addAllCerts
else
  addOneCert "$certID"
fi
