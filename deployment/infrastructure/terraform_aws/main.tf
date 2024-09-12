terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    godaddy = {
      source  = "n3integration/godaddy"
      version = "~> 1.9.1"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.AWS_DEFAULT_ZONE
}

provider "godaddy" {}


# EC2 INSTANCES

resource "aws_instance" "django_boilerplate_webserver" {
  ami                         = "ami-002a875adefcee7fc"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.django_boilerplate_private_ssh_key_pair.key_name
  subnet_id                   = aws_subnet.public_subnet_1.id
  tags = {
    Name = "django_boilerplate backend"
  }

  availability_zone = var.AWS_DEFAULT_AVAILABILITY_ZONES[0]
  security_groups = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_https.id,
    aws_security_group.allow_all_outbound_connections.id
  ]
}


# RDS INSTANCES

resource "aws_db_instance" "django_boilerplate" {
  identifier = "django_boilerplate"
  db_name    = "django_boilerplate"
  username   = "root"
  password   = var.AWS_DB_PASSWORD_DJANGO_BOILERPLATE
  tags = {
    Name = "django_boilerplate backend"
  }

  availability_zone    = var.AWS_DEFAULT_AVAILABILITY_ZONES[0]
  db_subnet_group_name = aws_db_subnet_group.django_boilerplate_private_db_subnet_group.name
  vpc_security_group_ids = [
    aws_security_group.allow_rds_postgres_connection.id,
    aws_security_group.allow_all_outbound_connections.id
  ]

  port                    = "5432"
  engine                  = "postgres"
  engine_version          = "14.6"
  instance_class          = "db.t4g.micro"
  allocated_storage       = "20" # GB
  storage_type            = "gp2"
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 7
}


# OUTPUTS

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.django_boilerplate_webserver.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_eip.django_boilerplate_ip.public_ip
}

output "db_instance_host" {
  description = "Public IP address of the RDS instance"
  value       = aws_db_instance.django_boilerplate.address
}

output "project_ssh_key" {
  description = "A new key was generated on ~/.ssh/ to access the EC2 with SSH"
  value       = "Saved at ${local_sensitive_file.django_boilerplate_private_ssh_key.filename}"
}
