# Variables
TF_DOCS_VERSION = v0.15.0
TFSEC_VERSION = 0.58.1

.PHONY: lint format plan security

lint:
	@echo "🔍 Linting Terraform code..."
	terraform fmt -check -recursive

format:
	@echo "✨ Formatting Terraform code..."
	terraform fmt -recursive

plan: format lint
	@echo "📋 Planning Terraform changes..."
	terraform init
	terraform plan -input=false

security:
	@echo "🔒 Running security checks with tfsec..."
	@tfsec .

docs:
	@echo "📚 Generating Terraform documentation..."
	terraform-docs markdown table . > README.md

install-terraform-docs:
	@echo "🛠️ Installing Terraform Docs..."
	@curl -sSL https://github.com/terraform-docs/terraform-docs/releases/download/$(TF_DOCS_VERSION)/terraform-docs-$(TF_DOCS_VERSION)-$(shell uname -s | tr '[:upper:]' '[:lower:]')-amd64.tar.gz | tar xz -C /tmp/
	@sudo mv /tmp/terraform-docs /usr/local/bin/

tf-lint:
	@echo "🔍 Linting Terraform code in $(DIRECTORY)..."
	terraform fmt -check=true -diff=true $(DIRECTORY)

apply: plan
	@echo "🚀 Applying Terraform changes..."
	terraform apply -auto-approve

destroy:
	@echo "🔥 Destroying Terraform resources..."
	terraform destroy -auto-approve