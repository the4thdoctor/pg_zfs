#
#
#
.ONESHELL:
.SHELL := /bin/bash
.PHONY: remove-temporary-password
CURRENT_FOLDER=$(shell basename "$$(pwd)")
BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
GREEN=$(shell tput setaf 2)
YELLOW=$(shell tput setaf 3)
RESET=$(shell tput sgr0)
extra ?= "-e 'makefile=true' -v"
ansible_user ?= "ansible"
vault_pwd_file ?= ~/.ansible/kd_testing_pwd
vault_all_file ?= inventory/gcp/group_vars/all/vault.yml
ifndef vault_id_pwd
	ifneq ("$(wildcard $(vault_pwd_file))","")
    	vault_pwd = "--vault-password-file=${vault_pwd_file}"
	else
		vault_pwd = "--ask-vault-pass"
	endif
endif



help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

ping-hosts: ## Ping the hosts
	@ansible ${vault_pwd} -u ${ansible_user} -i inventory/gcp/hosts --diff -m ping hosts $(extra)

all: ext4 zfs sysctl postgres monitor ## Configures the machines applying in sequence all roles

reconfigure: ## run tests on ext4
	@ansible-playbook ${vault_pwd} -u ${ansible_user} -i inventory/gcp/hosts --diff playbooks/reconfigure_system.yml $(extra)
	

run-ext4-test: ## run tests on ext4
	@ansible-playbook ${vault_pwd} -u ${ansible_user} -i inventory/gcp/hosts --diff playbooks/run_ext4_test.yml $(extra)
	
run-zfs-test: ## run tests on zfs
	@ansible-playbook ${vault_pwd} -u ${ansible_user} -i inventory/gcp/hosts --diff playbooks/run_zfs_test.yml $(extra)
	
sysctl: ## Setup sysctl
	@ansible-playbook ${vault_pwd} -u ${ansible_user} -i inventory/gcp/hosts --diff playbooks/setup_sysctl.yml $(extra)

postgres: ## Setup postgresql
	@ansible-playbook ${vault_pwd} -u ${ansible_user} -i inventory/gcp/hosts --diff playbooks/setup_postgres.yml $(extra)

monitor: ## Setup prometheus and monitoring
	@ansible-playbook ${vault_pwd} -u ${ansible_user} -i inventory/gcp/hosts --diff playbooks/setup_monitor.yml $(extra)

ext4: ## Setup the lvm on the vm
	@ansible-playbook ${vault_pwd} -u ${ansible_user} -i inventory/gcp/hosts --diff playbooks/setup_ext4.yml $(extra)

zfs: ## Setup the lvm on the vm
	@ansible-playbook ${vault_pwd} -u ${ansible_user} -i inventory/gcp/hosts --diff playbooks/setup_zfs.yml $(extra)


create-vault: ## Create a new vault file in gcp/group_vars/all/vault.yml
	@ansible-vault create ${vault_pwd}  ${vault_all_file}

edit-vault: ## Edit the vault file stored in gcp/group_vars/all/vault.yml
	@ansible-vault edit ${vault_pwd}  ${vault_all_file}

rekey-vault: ## Change the vault encryption key
	@ansible-vault rekey ${vault_pwd}  ${vault_all_file}