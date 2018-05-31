get:
	terraform get

init:
	terraform init

plan:
	terraform plan -var-file="config/secret.tfvars"

apply:
	terraform apply -var-file="config/secret.tfvars" -auto-approve

destroy:
	terraform destroy -var-file="config/secret.tfvars"

install-graph:
	brew install graphviz

graph:
	terraform graph | dot -Tpng > graph.png
	# terraform graph -module-depth=0 | dot -Tpng > graph.png