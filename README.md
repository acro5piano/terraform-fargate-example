# Terraform & Fargate example

A dead simple example to setup AWS Fargate service + Terraform

# Features

- Use [Terraform](https://www.terraform.io) to setup AWS ECS basic environment
- Use [Fargate CLI](https://github.com/awslabs/fargatecli) to create Fargate services without hassle
- Zero-downtime deploy thanks to Fargate

# Why

We can create all of AWS ECS environment with Terraform. However, it requires a lot of Terraform boilerplates and understanding how Terraform works. Instead of copy & paste HCL from the Terraform document, let's delegate some parts to Fargate CLI.

# How to use

### Initial Setup

```sh
cp aws-credentials.ini.example aws-credentials.ini

# Add your credentials
vim aws-credentials.ini

# Provision Terraform managed infrastructure
terraform init
terraform apply

# Create ECS Fargate service
make create
```

### Show information

```sh
make info
```

### Deploy service

```sh
make deploy
```

Note: This will build `Dockerfile` in the current directory. If you have other deploy strategy, edit `Makefile`.

### Delere everything

```sh
make destroy
terraform destroy
```

Note: ECS Execution Role will not be deleted.

# What will be created?

By Terraform:

- ECS Cluser
- EC2 Security Group

By Fargate CLI:

- ECR Repository
- ECS Task Definition
- ECS Service
- ECS Task
- ECS Task Execution Role
- ALB
- ALB Target Group
- CloudWatch Log Group
