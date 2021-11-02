provider "aws" {
  region = "us-west-1"
}

terraform {
  backend "s3" {
    bucket = "nimbusdevops"
    key    = "terraform-state/stage/web/terraform.tfstate"
    region = "us-west-1"

    dynamodb_table = "tf-locks-stage-web"
    encrypt        = true
  }
}

module "webserver-cluster" {
  source = "../../modules/webserver-cluster"

  security_group_name    = "webservers-stage"
  asg_name               = "asg-stage"
  lt_name                = "launch-template-stage"
  template_instance_type = "t2.micro"
  key_pair               = "ndo-key-stage"
  instance_name_tag      = "ndo-web-stage"
  alb_name               = "ndo-alb-stage"
  tg_name                = "ndo-tg-stage"
  sg_name_tag            = "allowHTTPstage"
  asg_desired            = "2"
  asg_min                = "2"
  asg_max                = "3"
}