SHELL := /usr/bin/env bash
# HOW TO EXECUTE

# Executing Terraform PLAN
#	$ make tf-plan 
#    e.g.,
#       make tf-plan env=dev

# Executing Terraform APPLY
#   $ make tf-apply 

# Executing Terraform DESTROY
#	$ make tf-destroy 

all-test: clean tf-plan

.PHONY: clean
clean:
	rm -rf .terraform

.PHONY: tf-plan
tf-plan:
	terraform fmt -recursive && terraform init && terraform validate && terraform plan -var-file D211.tfvars

.PHONY: tf-apply
tf-apply:
	terraform fmt -recursive && terraform init && terraform validate && terraform apply -var-file D211.tfvars -auto-approve

.PHONY: tf-destroy
tf-destroy:
	terraform init && terraform destroy -var-file D211.tfvars -auto-approve