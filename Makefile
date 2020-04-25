WEBAPP_ECS_SECURITY_GROUP := `terraform state show aws_security_group.webapp | grep arn | perl -pe 's/.+\/sg\-(.+)"/sg-\1/'`
WEBAPP_LB_SECURITY_GROUP := `terraform state show aws_security_group.webapp_lb | grep arn | perl -pe 's/.+\/sg\-(.+)"/sg-\1/'`
WEBAPP_REPOSITORY_URL := `terraform state show aws_ecr_repository.webapp | grep repository_url | perl -pe 's/.+"(.+)"/\1/'`

info:
	./fargate-wrapper.sh service info webapp --cluster webapp
	./fargate-wrapper.sh lb list --cluster webapp

create:
	./fargate-wrapper.sh lb create webapp \
		--cluster webapp \
		--port HTTP:80 \
		--security-group-id $(WEBAPP_LB_SECURITY_GROUP)
	./fargate-wrapper.sh service create webapp \
		--cluster webapp \
		--lb webapp \
		--num 1 \
		--port HTTP:3000 \
		--cpu 256 \
		--memory 512 \
		--security-group-id $(WEBAPP_ECS_SECURITY_GROUP) \
		--image $(WEBAPP_REPOSITORY_URL)

deploy:
	./fargate-wrapper.sh service deploy webapp \
		--cluster webapp

destroy:
	./fargate-wrapper.sh service scale webapp 0 --cluster webapp
	./fargate-wrapper.sh service destroy webapp --cluster webapp
	./fargate-wrapper.sh lb destroy webapp

help:
	@echo Available commands:
	@echo make info
	@echo make create
	@echo make deploy
	@echo make destroy

.DEFAULT_GOAL := help
