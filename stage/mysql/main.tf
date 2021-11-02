provider "aws" {
  region = "us-west-1"
}

terraform {
  backend "s3" {
    bucket = "nimbusdevops"
    key    = "terraform-state/stage/mysql/terraform.tfstate"
    region = "us-west-1"

    dynamodb_table = "tf-locks-stage-mysql"
    encrypt        = true
  }
}

resource "aws_db_instance" "ndo-mysql-stage" {
  identifier_prefix = "nimbusdevops"
  engine            = "mysql"
  allocated_storage = 10
  instance_class    = "db.t2.micro"
  name              = "ndoMysqlStage"
  username          = "ndoadmin"
  password          = "ndopassword"
  skip_final_snapshot = true
}