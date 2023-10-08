

package:
	helm package helm-chart/ray-cluster -d docs/
	helm repo index docs/ --url https://raw.githubusercontent.com/MeliorAI/kuberay-helm/experiment/lint-ray-worker/docs