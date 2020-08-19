init:
	terraform init

install-fargatecli:
	wget https://github.com/awslabs/fargatecli/releases/download/0.3.2/fargate-0.3.2-linux-amd64.zip
	unzip fargate-0.3.2-linux-amd64.zip
	chmod +x fargate
	sudo mv fargate /usr/bin/fargate
	fargate --version

info:
	terraform output
	./fargate-wrapper.sh service info webapp --cluster webapp
	./fargate-wrapper.sh lb list --cluster webapp

create:
	terraform apply
	./fargate-wrapper.sh lb create webapp \
		--cluster webapp \
		--port HTTP:80 \
		--security-group-id `terraform output webapp_lb_security_group`
	./fargate-wrapper.sh service create webapp \
		--cluster webapp \
		--lb webapp \
		--num 1 \
		--port HTTP:3000 \
		--cpu 256 \
		--memory 512 \
		--security-group-id `terraform output webapp_ecs_security_group`

deploy:
	./fargate-wrapper.sh service deploy webapp \
		--cluster webapp

destroy:
	@echo 'Are you okay to delete everything? [Y/n]'
	@read ans && test $$ans == 'Y'
	./fargate-wrapper.sh service scale webapp 0 --cluster webapp
	./fargate-wrapper.sh service destroy webapp --cluster webapp
	./fargate-wrapper.sh lb destroy webapp
	terraform destroy

help:
	@echo Available commands:
	@echo make info
	@echo make create
	@echo make deploy
	@echo make destroy

.DEFAULT_GOAL := help
