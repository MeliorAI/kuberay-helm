# KubeRay Helm Charts

This repository hosts Helm charts for the [KubeRay](https://github.com/ray-project/kuberay) project since KubeRay v0.4.0.

## Requirements

 - [Helm](https://helm.sh/) must be installed to use the charts.
   Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.


## Realease HowTo

### Code updates

> Update versions in Chart.yaml and values.yaml files

Please update the value of `version` in:

 - [ray-cluster/Chart.yaml](https://github.com/MeliorAI/kuberay-helm/blob/master/helm-chart/ray-cluster/Chart.yaml),
 - [kuberay-operator/Chart.yaml](https://github.com/MeliorAI/kuberay-helm/blob/master/helm-chart/kuberay-operator/Chart.yaml),
 - [kuberay-apiserver/Chart.yaml](https://github.com/MeliorAI/kuberay-helm/blob/master/helm-chart/kuberay-apiserver/Chart.yaml)

To the new release version (e.g. 0.4.0).

Also make sure `image.tag` has been updated in [kuberay-operator/values.yaml](https://github.com/MeliorAI/kuberay-helm/blob/master/helm-chart/kuberay-operator/values.yaml) and [kuberay-apiserver/values.yaml](https://github.com/MeliorAI/kuberay-helm/blob/master/helm-chart/kuberay-apiserver/values.yaml).


### Github as a Helm repo

1. Setup github pages to publish `docs` folder as github pages
    (you can use a different name, just substitue later)

2. Package the helm repo as .tgz (using helm package) & generate an `index.yaml`:
    ```bash
    make package
    ```

## End-to-end HowTo

### Setup

```bash
# Step 1: Create a KinD cluster
kind create cluster

# Step 1.b: (Optional) Add the registry secret to pull private images from docker-hub
kubectl create secret generic regcred \
    --from-file=.dockerconfigjson=$HOME/.docker/config.json \
    --type=kubernetes.io/dockerconfigjson

# Step 2: Register a Helm chart repo
helm repo add lint-ray https://raw.githubusercontent.com/MeliorAI/kuberay-helm/main/docs/
# Or if already present
helm repo update

# Step 3 (Optional) Docker image pre-loaded from your local machine:
kind load docker-image meliorai/lint-worker:0.1.0
```

### Installing Ray Cluster

```bash
# Step 3: Install both CRDs and KubeRay operator v1.0.0-rc.0.
helm install kuberay-operator lint-ray/kuberay-operator --version 1.0.0-rc.0

# Step 4: Install a RayCluster custom resource
# (For x86_64 users)
helm install raycluster lint-ray/ray-cluster --version 1.0.0-rc.0
# TBD: (For arm64 users, e.g. Mac M1)
# See here for all available arm64 images: https://hub.docker.com/r/rayproject/ray/tags?page=1&name=aarch64
helm install raycluster kuberay/ray-cluster --version 1.0.0-rc.0 --set image.tag=nightly-aarch64

# Step 5: Verify the installation of KubeRay operator and RayCluster
kubectl get pods
# NAME                                          READY   STATUS    RESTARTS   AGE
# kuberay-operator-6fcbb94f64-gkpc9             1/1     Running   0          89s
# raycluster-kuberay-head-qp9f4                 1/1     Running   0          66s
# raycluster-kuberay-worker-workergroup-2jckt   1/1     Running   0          66s

# Step 6: Forward the port of Dashboard
kubectl port-forward --address 0.0.0.0 svc/raycluster-kuberay-head-svc 8265:8265

# Step 7: Check ${YOUR_IP}:8265 for the Dashboard (e.g. 127.0.0.1:8265)

# Step 8: Log in to Ray head Pod and execute a job.
kubectl exec -it ${RAYCLUSTER_HEAD_POD} -- bash
python -c "import ray; ray.init(); print(ray.cluster_resources())" # (in Ray head Pod)

# Step 9: Check ${YOUR_IP}:8265/#/job. The status of the job should be "SUCCEEDED".

# Step 10: Uninstall RayCluster
helm uninstall raycluster

# Step 11: Verify that RayCluster has been removed successfully
# NAME                                READY   STATUS    RESTARTS   AGE
# kuberay-operator-6fcbb94f64-gkpc9   1/1     Running   0          9m57s
```

