##@ Development

define HELP_INIT
# Init Helm by adding the stable repository.
#
# The stable repository is no longer added by default.
# Refs:
#  - https://helm.sh/blog/helm-v3-beta/#notable-changes-since-helm-v2
#  - https://helm.sh/docs/intro/quickstart/#initialize-a-helm-chart-repository
#
# Example:
#   make init
endef
.PHONY: init
ifeq ($(HELP),y)
init:
	$(Q) echo "$$HELP_INIT"
else
init: ## Init Helm
	$(Q) $(HELM) repo add stable $(HELM_REPO_STABLE_URL)
	$(Q) $(HELM) repo add incubator $(HELM_REPO_INCUBATOR_URL)
endif

define HELP_DEP
# Rebuild charts dependencies.
#
# Example:
#   make dep
endef
.PHONY: dep
ifeq ($(HELP),y)
dep:
	$(Q) echo "$$HELP_DEP"
else
dep: init ## Rebuild charts dependencies
	$(Q) find $(CHARTS_DIR) \
		-mindepth 1 \
		-maxdepth 1 \
		-type d \
		-exec $(HELM) dep update {} \; \
		-exec $(HELM) dep build {} \;
endif

define HELP_LINT
# Examine charts for possible issues.
#
# Example:
#   make lint
endef
.PHONY: lint
ifeq ($(HELP),y)
lint:
	$(Q) echo "$$HELP_LINT"
else
lint: ## Lint charts
	$(Q) find $(CHARTS_DIR) \
		-mindepth 1 \
		-maxdepth 1 \
		-type d \
		-exec $(HELM) lint {} \;
endif
