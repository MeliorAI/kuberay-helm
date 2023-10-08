# KubeRay Helm Charts

This repository hosts Helm charts for the [KubeRay](https://github.com/ray-project/kuberay) project since KubeRay v0.4.0.

## Requirements

 - [Helm](https://helm.sh/) must be installed to use the charts. 
   Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.


### Adding as a Helm repo

GitHub pages can be used to 

1. Setup github pages to publish docs folder as github pages (you can use a different name, just substitue later)

2. Package the helm repo as .tgz (using helm package): 
    `helm package helm-charts/ray-cluster -d docs/.`

3. Include an index.yaml - an index file for the repository helm repo index ./docs
    `https://josemaro.github.io/<REPO_NAME>`

4. Now you can add the repo: 
    ```
    helm repo add <INTERNAL_NAME> https://<YOUR_ORG_OR_USERNAME>.github.io/<REPO_NAME>
    ```

Once Helm is set up properly, add the repo as follows:

TBD 
```sh
helm repo add kuberay https://lint-ray-project.github.io/kuberay-helm/
helm install kuberay kuberay/kuberay-operator
```

You can then run `helm search repo kuberay` to see the charts.