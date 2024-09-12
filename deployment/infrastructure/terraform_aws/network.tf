# VPCs

resource "aws_vpc" "main_vpc" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "Django BoilerplateBackend"
  }
}


# SUBNETS

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, 1) # "172.16.1.0/24"
  availability_zone = var.AWS_DEFAULT_AVAILABILITY_ZONES[0]
  tags = {
    Name = "Django BoilerplateBackend"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, 2) # "172.16.2.0/24"
  availability_zone = var.AWS_DEFAULT_AVAILABILITY_ZONES[0]
  tags = {
    Name = "Django BoilerplateBackend"
  }
}
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, 3) # "172.16.3.0/24"
  availability_zone = var.AWS_DEFAULT_AVAILABILITY_ZONES[1]
  tags = {
    Name = "Django BoilerplateBackend"
  }
}

resource "aws_db_subnet_group" "django_boilerplate_private_db_subnet_group" {
  name        = "django_boilerplate_private_db_subnet_group"
  subnet_ids  = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  description = "Subnet group to connect RDS and EC2 instances"
  tags = {
    Name = "Django BoilerplateBackend"
  }
}


# IP Addresses

resource "aws_eip" "django_boilerplate_ip" {
  instance = aws_instance.django_boilerplate_webserver.id
  vpc      = true
  tags = {
    Name = "Django BoilerplateBackend"
  }
}


# GATEWAYS

resource "aws_internet_gateway" "main-gateway" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "Django BoilerplateBackend"
  }
}

resource "aws_nat_gateway" "private_nat_gateway" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.public_subnet_1.id
  tags = {
    Name = "Django BoilerplateBackend"
  }
}


# ROUTE TABLES

resource "aws_route_table" "internet_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "Django BoilerplateBackend"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gateway.id
  }
}

resource "aws_route_table" "database_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "Django BoilerplateBackend"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.private_nat_gateway.id
  }
}


# ROUTE TABLE ASSOCIATIONS

resource "aws_route_table_association" "add_internet_to_public_subnet_1" {
  route_table_id = aws_route_table.internet_route_table.id
  subnet_id      = aws_subnet.public_subnet_1.id
}

resource "aws_route_table_association" "add_database_connection_to_public_subnet_1" {
  route_table_id = aws_route_table.database_route_table.id
  subnet_id      = aws_subnet.private_subnet_1.id
}


# DNS

resource "godaddy_domain_record" "godaddy_django_boilerplate" {
  domain = "django_boilerplate.com"

  record {
    name     = "@"
    type     = "A"
    data     = aws_eip.django_boilerplate_ip.public_ip
    ttl      = 600
    priority = 0
  }

  record {
    name     = "www"
    type     = "CNAME"
    data     = "@"
    ttl      = 3600
    priority = 0
  }
}
