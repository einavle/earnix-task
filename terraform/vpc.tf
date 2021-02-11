
provider "aws" {
  region = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  max_retries = 1
}

resource "aws_vpc" "vpc-earnix" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = "true"
  tags = {
    Name = "earnix1"
  }
}

resource "aws_subnet" "earnix-subnet-a" {
  vpc_id = aws_vpc.vpc-earnix.id
  cidr_block = "10.0.101.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "aws-z1-earnix-pub"
  }
}

resource "aws_subnet" "earnix-subnet-b" {
  vpc_id = aws_vpc.vpc-earnix.id
  cidr_block = "10.0.102.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "aws-z2-earnix-pub"
  }
}
