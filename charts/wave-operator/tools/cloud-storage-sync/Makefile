.DEFAULT_GOAL := help

# Image URL to use all building/pushing image targets
IMG ?= ntfrnzn/cloud-storage-sync:latest

docker-build:   ## Build the docker image
	docker build . -t ${IMG}

docker-push:  ## Push the docker image
	docker push ${IMG}

.PHONY: help
help: ## Display this help
	awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

