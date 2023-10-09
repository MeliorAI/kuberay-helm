

package:
	helm package helm-chart/ray-cluster -d docs/
	helm package helm-chart/kuberay-apiserver -d docs/
	helm package helm-chart/kuberay-operator -d docs/
	helm repo index docs/ --url https://raw.githubusercontent.com/MeliorAI/kuberay-helm/main/docs/
