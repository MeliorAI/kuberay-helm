

package:
	helm package helm-chart/ray-cluster -d docs/
	helm repo index docs/ --url https://raw.githubusercontent.com/josemarcosrf/lint-worker-kuberay-helm/experiment/lint-ray-worker/docs