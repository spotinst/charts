#!/usr/bin/env bash

function helm_index() {
	echo "==> Indexing channel: ${CHANNEL}"

	channel_url="${HELM_REPO_SPOT_URL}/${CHANNEL}"
	channel_dir="${RELEASES_DIR}/${CHANNEL}"

	# Do NOT attempt to index empty directories.
	[[ ! -d "${channel_dir}" ]] && return

	${HELM} repo index \
		--url "${channel_url}" \
		"${channel_dir}"
}

function main() {
	CHANNEL="alpha"  helm_index
	CHANNEL="stable" helm_index
}

main
