#!/usr/bin/env sh

# Works on a macs.
# A K8s helper script to run commands on some pod of the given service.

# Init
if [ $# -eq 0 ]
  then
    echo "Usage: $ serviceShell.sh {serviceName} (commands|/bin/bash)"
fi

if [ ! -z $2 ]
  then
    command=${@:2:${#}}

  else
    command=/bin/bash
fi

# Helpers
coln() { # Picks the given (nth) column from the fed lines. Ex: $ echo a b | coln 2 # Gives: b

  var=$1
  awk -v "col=${var}" '{print $col}'
}

# Main
TGT_POD=`kubectl get pods | grep $1 | coln 1 | head -n 1`

kubectl exec -it $TGT_POD -- $command
