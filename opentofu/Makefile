.ONESHELL:
.SHELL := /bin/bash
.PHONY: apply plan init destroy-target
CURRENT_FOLDER=$(shell basename "$$(pwd)")

BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
GREEN=$(shell tput setaf 2)
YELLOW=$(shell tput setaf 3)
RESET=$(shell tput sgr0)
credential_file=~/.gcp/kd-testing.json
gcp_project="kd-testing-413112"

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

plan: ## Generates an opentofu plan
	@tofu plan -var credential_file="${credential_file}" -var gcp_project=${gcp_project}

init: ## Initialise the opentofu working dir
	@tofu init -var credential_file="${credential_file}" -var gcp_project=${gcp_project}

apply: ## Applies the opentofu infrastructure
	@tofu apply -auto-approve -var credential_file="${credential_file}" -var gcp_project=${gcp_project}

destroy: ## Destroys the opentofu infrastructure
	@tofu destroy  -auto-approve -var credential_file="${credential_file}" -var gcp_project=${gcp_project}

destroy-target: ## Destroys the given target
	@tofu destroy  -auto-approve -var credential_file="${credential_file}" -var gcp_project=${gcp_project} --target=${TARGET}
