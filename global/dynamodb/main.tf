provider "aws" {
  region = "us-west-1"
}

resource "aws_dynamodb_table" "tf-locks-stage-web" {
  name         = "tf-locks-stage-web"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "tf-locks-stage-mysql" {
  name         = "tf-locks-stage-mysql"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "tf-locks-stage-network" {
  name         = "tf-locks-stage-network"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "tf-locks-prod-web" {
  name         = "tf-locks-prod-web"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "tf-locks-prod-mysql" {
  name         = "tf-locks-prod-mysql"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "tf-locks-prod-network" {
  name         = "tf-locks-prod-network"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}