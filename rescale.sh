#!/usr/bin/env sh

# Works on a macs.
# A K8s helper script to run commands on some pod of the given service.

# Init
if [ $# -eq 0 ]
  then
    echo "Usage: $ rescale.sh {serviceName} (replicas|1)"
    exit
fi

serviceName=$1
replicas=${2:-1}

kubectl scale deployments $serviceName --replicas=0
kubectl scale deployments $serviceName --replicas=$replicas
