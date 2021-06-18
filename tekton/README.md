# Tekton Installation

This doc will cover how to set up [TektonCD](https://tekton.dev/) with support for SPIRE.

For now, we are using a custom entrypointer image that is responsible for mounting in the SPIRE socket and requesting SVIDs from SPIRE. 
This image is currently built from this [branch](https://github.com/tektoncd/pipeline/compare/main...dlorenc:spire?expand=1).

You have two options for deploying this custom entrypointer image:
1. Use our prebuilt entrypointer image, built from the fork above
1. Build it yourself from the branch

## Prebuilt Image

To use the prebuilt image, first [install TektonCD](https://tekton.dev/docs/getting-started/#installation) in your cluster.

Now, you'll need to edit the Tekton deployment to tell it to use the custom entrypointer image:

```
kubectl edit -n tekton-pipelines deploy tekton-pipelines-controller
```

and replace the value of the [-entrypoint-image flag](https://github.com/tektoncd/pipeline/blob/main/config/controller.yaml#L74) to this image:


```
gcr.io/ref-arch-wg/entrypoint-bff0a22da108bc2f16c818c97641a296@sha256:600bc3e7115129687e77a130a8df604d67d857eafe07981d1c524fdf54d98c30
```

## Build yourself from source

Pull in the entrypointer fork to your Tekton pipelines repo:

```
git clone https://github.com/dlorenc/build-pipeline
cd build-pipeline
git checkout spire
```

Now, build the Tekton fork and deploy to cluster with [ko](https://github.com/google/ko):

```
export KO_DOCKER_REPO=<your repo>
ko apply -f config
```
