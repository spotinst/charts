.EXPORT_ALL_VARIABLES:

# Make.
MAKEFLAGS                += --no-builtin-rules
.SUFFIXES:

# Shell.
SHELL                    := bash
.SHELLFLAGS              := -eu -o pipefail -c

# Utilities.
V                        := 0
Q                        := $(if $(filter 1,$(V)),,@)
TIMESTAMP                 = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")

# Directories.
ROOT_DIR                  = $(CURDIR)
CHARTS_DIR                = $(ROOT_DIR)/charts

# Helm.
HELM                     ?= /usr/local/bin/helm --debug
HELM_REPO_STABLE_URL     := https://charts.helm.sh/stable
HELM_REPO_INCUBATOR_URL  := https://charts.helm.sh/incubator
HELM_REPO_SPOT_URL       := https://charts.spot.io
