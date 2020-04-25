WEBAPP_ECS_SECURITY_GROUP := `terraform state show aws_security_group.webapp | grep arn | perl -pe 's/.+\/sg\-(.+)"/sg-\1/'`
WEBAPP_LB_SECURITY_GROUP := `terraform state show aws_security_group.webapp_lb | grep arn | perl -pe 's/.+\/sg\-(.+)"/sg-\1/'`
WEBAPP_REPOSITORY_URL := `terraform state show aws_ecr_repository.webapp | grep repository_url | perl -pe 's/.+"(.+)"/\1/'`

info:
	bin/fargate service info webapp --cluster webapp
	bin/fargate lb list --cluster webapp

create:
	bin/fargate lb create webapp \
		--cluster webapp \
		--port HTTP:80 \
		--security-group-id $(WEBAPP_LB_SECURITY_GROUP)
	bin/fargate service create webapp \
		--cluster webapp \
		--lb webapp \
		--port HTTP:3000 \
		--cpu 256 \
		--memory 512 \
		--security-group-id $(WEBAPP_ECS_SECURITY_GROUP) \
		--image $(WEBAPP_REPOSITORY_URL)

deploy:
	bin/fargate service deploy webapp \
		--cluster webapp \
		--image $(WEBAPP_REPOSITORY_URL)

destroy:
	bin/fargate service scale webapp 0 --cluster webapp
	bin/fargate service destroy webapp --cluster webapp
	bin/fargate lb destroy webapp

help:
	@echo Available commands:
	@echo make info
	@echo make create
	@echo make deploy
	@echo make destroy

.DEFAULT_GOAL := help
