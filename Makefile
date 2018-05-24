get:
	terraform get

init:
	terraform init

plan:
	terraform plan -var-file=secret.tfvars

apply:
	terraform apply -var-file=secret.tfvars

destroy:
	terraform destroy -var-file=secret.tfvars

install-graph:
	brew install graphviz

graph:
	terraform graph | dot -Tpng > graph.png
	# terraform graph -module-depth=0 | dot -Tpng > graph.png