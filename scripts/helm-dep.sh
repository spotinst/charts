#!/usr/bin/env bash

function helm_dep() {
	chart_dir="$1"
	chart_name="$(basename "${chart_dir}")"

	echo "==> Rebuilding chart dependencies: ${chart_name}"
	pushd "${chart_dir}" >/dev/null
	${HELM} dependency update
	${HELM} dependency build
	popd >/dev/null
}

function helm_channel() {
	find "${CHARTS_DIR}/${CHANNEL}" \
		-mindepth 1 \
		-maxdepth 1 \
		-type d \
		-exec bash -c 'helm_dep "$0"' {} \;
}

function main() {
	export -f helm_dep

	CHANNEL="alpha" helm_channel
	CHANNEL="stable" helm_channel
}

main
