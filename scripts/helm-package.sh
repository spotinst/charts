#!/usr/bin/env bash

function helm_package() {
	chart_dir="$1"
	chart_name="$(basename "${chart_dir}")"

	echo "==> Packaging chart: ${chart_name}"
	${HELM} package \
		--destination "${RELEASES_DIR}/${CHANNEL}" \
		"${chart_dir}"
}

function helm_channel() {
	find "${CHARTS_DIR}/${CHANNEL}" \
		-mindepth 1 \
		-maxdepth 1 \
		-type d \
		-exec bash -c 'helm_package "$0"' {} \;
}

function main() {
	export -f helm_package

	CHANNEL="alpha"  helm_channel
	CHANNEL="stable" helm_channel
}

main
