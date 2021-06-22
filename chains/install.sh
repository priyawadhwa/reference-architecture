#!/usr/bin/env bash
set -ex

TEMPDIR=$(mktemp -d)
echo "Created tempdir $TEMPDIR" 
cd $TEMPDIR

git clone https://github.com/tektoncd/chains.git
cd chains
git checkout spire

ko apply -f config

kubectl patch configmap chains-config -n tekton-chains -p='{"data":{"spire.enabled": "true"}}'
