# Removendo as variáveis de cores que estavam causando erros tput
# e simplificando a formatação

include .env

ARM_CLIENT_ID		?= $(shell grep ARM_CLIENT_ID .env | cut -d '=' -f2)
ARM_CLIENT_SECRET	?= $(shell grep ARM_CLIENT_SECRET .env | cut -d '=' -f2)
ARM_SUBSCRIPTION_ID	?= $(shell grep ARM_SUBSCRIPTION_ID .env | cut -d '=' -f2)
ARM_TENANT_ID		?= $(shell grep ARM_TENANT_ID .env | cut -d '=' -f2)

TF_PLAN_FILE        = tf.plan
VAR_FILE            = terraform.tfvars

CHDIR = -chdir=examples/network-basic

.PHONY: help
help:
	@echo "Comandos disponíveis:"
	@echo "  login         	- Realiza login no Azure usando service principal"
	@echo "  init          	- Inicializa o Terraform"
	@echo "  validate      	- Valida o Terraform"
	@echo "  plan          	- Gera o plano de execução do Terraform"
	@echo "  apply         	- Aplica as mudanças planejadas"
	@echo "  destroy       	- Destrói toda a infraestrutura"
	@echo "  all           	- Executa todo o processo (login, init, plan, apply)"
	@echo "  pc	    		- Executa o pre-commit run -a"
	@echo "  git    		- Executa o git add, commit e push"
	@echo "  clean    		- Limpa o cache do Terraform e do Terragrunt"
.DEFAULT_GOAL := help

login:
	@echo ""
	@echo "Azure Logout"
	@az logout
	@echo "Azure Account Clear"
	@az account clear
	@az config set core.output=table --only-show-errors
	@echo "Azure Login"
	@az login \
		-u $(ARM_CLIENT_ID) \
		-p $(ARM_CLIENT_SECRET) \
		--tenant $(ARM_TENANT_ID) \
		--service-principal
	@az account set --subscription $(ARM_SUBSCRIPTION_ID)
	@echo "Para carregar as variáveis no ambiente atual, execute manualmente: source .env"

init:
	@echo ""
	@echo "Terraform init"
	@terraform $(CHDIR) init -upgrade

validate:
	@echo ""
	@echo "Terraform validate"
	@terraform $(CHDIR) validate

plan: validate init
	@echo ""
	@echo "Terraform Plan"
	@terraform $(CHDIR) plan -out=$(TF_PLAN_FILE) -var-file=$(VAR_FILE)

apply: plan
	@echo ""
	@terraform $(CHDIR) apply -var-file=$(VAR_FILE) $(TF_PLAN_FILE)

destroy: validate init
	@echo ""
	@echo "Terraform Destroy"
	@terraform $(CHDIR) destroy -auto-approve -var-file=$(VAR_FILE)

all: apply

pc:
	@echo ""
	@echo "Pre-commit run -a"
	@git add .
	@pre-commit run -a

git:
	@echo ""
	@echo "Git add, commit e push"
	@git add .
	@read -p "Digite sua mensagem de commit: " message; \
	read -p "Digite a tag (ex: v1.0.0): " tag; \
	git commit -m "$$message"; \
	git tag -a $$tag -m "$$message" -f; \
	git push origin $$tag -f
	@git push

clean:
	@echo ""
	@echo "Limpando cache do Terragrunt"
	@find . -type d -name '.terragrunt-cache' -prune -exec rm -rf {} \;
	@echo "Limpando cache do Terraform"
	@find . -type d -name '.terraform'  -prune -exec rm -rf {} \;
	@find . -type f -name '.terraform.lock.hcl' -exec rm -f {} \;
	@echo "Limpando arquivos :Zone.Identifier"
	@find . -type f -name '*:Zone.Identifier' -exec rm -f {} \;