provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "./aws-credentials.ini"
  profile                 = "default"
}

resource "aws_ecs_cluster" "webapp" {
  name = "webapp"
}

resource "aws_ecr_repository" "webapp" {
  name = "webapp"
}

resource "aws_security_group" "webapp" {
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.webapp_lb.id]
  }
}

resource "aws_security_group" "webapp_lb" {
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "webapp_ecs_security_group" {
  value = aws_security_group.webapp.id
}

output "webapp_lb_security_group" {
  value = aws_security_group.webapp_lb.id
}
