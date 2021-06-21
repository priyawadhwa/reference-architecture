# Tekton Chains Installation

This doc will cover how to set up [Tekton Chains](https://github.com/tektoncd/chains/) with support for SPIRE.

SPIRE support for Chains lives in the `spire` branch, so you'll have to checkout that branch and deploy to cluster with [ko](https://github.com/google/ko):

```
git clone https://github.com/tektoncd/chains.git
cd chains
git checkout spire

export KO_DOCKER_REPO=<your repo>
ko apply -f config
```

And, enable support for SPIRE in Chains:

```
kubectl patch configmap chains-config -n tekton-chains -p='{"data":{"spire.enabled": "true"}}'
```
