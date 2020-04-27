#!/usr/bin/env bash

function main() {
	echo "==> Helm version: ${HELM_VERSION}"

	# The stable repository is no longer added by default. So let's add it.
	#
	# Refs:
	#  - https://helm.sh/blog/helm-v3-beta/#notable-changes-since-helm-v2
	#  - https://helm.sh/docs/intro/quickstart/#initialize-a-helm-chart-repository
	${HELM} repo add stable "${HELM_REPO_STABLE_URL}"
	${HELM} repo add incubator "${HELM_REPO_INCUBATOR_URL}"
}

main
