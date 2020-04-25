# Terraform & Fargate example

A dead simple example to setup AWS Fargate service + Terraform

# Features

- Use [Terraform](https://www.terraform.io) to setup AWS ECS basic environment
- Use [Fargate CLI](https://github.com/awslabs/fargatecli) to create Fargate services without hassle

# Why

We can create all of AWS ECS environment with Terraform. However, it requires a lot of Terraform boilerplates and understanding how Terraform works. Instead of copy & paste HCL from the Terraform document, let's delegate some parts to Fargate CLI.

# How to use

### Initial Setup

```
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

```
make info
```

### Delere everything

```
make destroy
```

Note: ECS Execution Role will not be deleted.

# What will be created?

By Terraform:

- ECR Repository
- ECS Cluser
- EC2 Security Group

By Fargate CLI:

- ECS Task Definition
- ECS Service
- ECS Task
- ECS Task Execution Role
- ALB
- ALB Target Group
