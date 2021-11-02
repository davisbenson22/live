provider "aws" {
  region = "us-west-1"
}

terraform {
  backend "s3" {
    bucket = "nimbusdevops"
    key    = "terraform-state/stage/network/terraform.tfstate"
    region = "us-west-1"

    dynamodb_table = "tf-locks-stage-network"
    encrypt        = true
  }
}

resource "aws_vpc" "terraformVPC" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "terraformVPC"
  }
}

resource "aws_internet_gateway" "terraformIGW" {
  vpc_id = aws_vpc.terraformVPC.id

  tags = {
    Name = "terraformIGW"
  }
}

resource "aws_route_table" "terraformRT" {
  vpc_id = aws_vpc.terraformVPC.id

  tags = {
    Name = "terraformRT"
  }
}

resource "aws_route" "terraformRoute" {
  route_table_id         = aws_route_table.terraformRT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.terraformIGW.id
}

resource "aws_main_route_table_association" "terraformMainRTAssoc" {
  vpc_id         = aws_vpc.terraformVPC.id
  route_table_id = aws_route_table.terraformRT.id
}

#NOT AVAILBLE IN US-WEST-1 REGION!!! (only us-west-1b and us-west-1c)
#resource "aws_subnet" "terraformPublicSubnetA" {
#  vpc_id                  = aws_vpc.terraformVPC.id
#  cidr_block              = "10.0.0.0/24"
#  availability_zone       = "us-west-1a"
#  map_public_ip_on_launch = true
#
#  tags = {
#    Name = "terraformPublicSubnetA"
#  }
#}

resource "aws_subnet" "terraformPublicSubnetB" {
  vpc_id                  = aws_vpc.terraformVPC.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraformPublicSubnetB"
  }
}

resource "aws_subnet" "terraformPublicSubnetC" {
  vpc_id                  = aws_vpc.terraformVPC.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraformPublicSubnetC"
  }
}

#NOT AVAILBLE IN US-WEST-1 REGION!!! (only us-west-1b and us-west-1c)
#resource "aws_route_table_association" "terraformRTAssocA" {
#  subnet_id      = aws_subnet.terraformPublicSubnetA.id
#  route_table_id = aws_route_table.terraformRT.id
#}
#
resource "aws_route_table_association" "terraformRTAssocB" {
  subnet_id      = aws_subnet.terraformPublicSubnetB.id
  route_table_id = aws_route_table.terraformRT.id
}

resource "aws_route_table_association" "terraformRTAssocC" {
  subnet_id      = aws_subnet.terraformPublicSubnetC.id
  route_table_id = aws_route_table.terraformRT.id
}