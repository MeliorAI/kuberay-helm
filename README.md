# KubeRay Helm Charts

This repository hosts Helm charts for the [KubeRay](https://github.com/ray-project/kuberay) project since KubeRay v0.4.0.

## Requirements

 - [Helm](https://helm.sh/) must be installed to use the charts. 
   Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.


## End-to-end HowTo 

### Code updates

> Update versions in Chart.yaml and values.yaml files

Please update the value of `version` in:

 - [ray-cluster/Chart.yaml](https://github.com/josemarcosrf/lint-worker-kuberay-helm/blob/master/helm-chart/ray-cluster/Chart.yaml),
 - [kuberay-operator/Chart.yaml](https://github.com/josemarcosrf/lint-worker-kuberay-helm/blob/master/helm-chart/kuberay-operator/Chart.yaml),
 - [kuberay-apiserver/Chart.yaml](https://github.com/josemarcosrf/lint-worker-kuberay-helm/blob/master/helm-chart/kuberay-apiserver/Chart.yaml)

To the new release version (e.g. 0.4.0).

Also make sure `image.tag` has been updated in [kuberay-operator/values.yaml](https://github.com/josemarcosrf/lint-worker-kuberay-helm/blob/master/helm-chart/kuberay-operator/values.yaml) and [kuberay-apiserver/values.yaml](https://github.com/josemarcosrf/lint-worker-kuberay-helm/blob/master/helm-chart/kuberay-apiserver/values.yaml).


### Adding as a Helm repo

1. Setup github pages to publish docs folder as github pages (you can use a different name, just substitue later)

2. Package the helm repo as .tgz (using helm package): 
    ```bash
    helm package helm-chart/ray-cluster -d docs/
    ```

3. Include an index.yaml:
    ```bash
    # https://<YOUR_ORG_OR_USERNAME>.github.io/<REPO_NAME>
    helm repo index docs/ --url https://raw.githubusercontent.com/josemarcosrf/lint-worker-kuberay-helm/experiment/lint-ray-worker/docs
    ```



### Install

1. Now you can add the repo to your helm: 
    ```
    # https://raw.githubusercontent.com/<YOUR_ORG_OR_USERNAME>/<REPO_NAME>/<BRANCH_USUALLY_MASTER>/<RELEASE_DIR>
    helm repo add lint-ray https://raw.githubusercontent.com/josemarcosrf/lint-worker-kuberay-helm/experiment/lint-ray-worker/docs

2. Install in yur cluster
    ```
    helm install kuberay lint-ray/ray-cluster --version 1.0.0-rc.0
    ```






