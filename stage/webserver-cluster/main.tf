

provider "aws" {
  region = "us-west-1"
}

# AWS backend configuration
#terraform {
#  backend "s3" {
#    bucket = "nimbusdevops"
#    key    = "terraform-state/stage/web/terraform.tfstate"
#    region = "us-west-1"
#
#    dynamodb_table = "tf-locks-stage-web"
#    encrypt        = true
#  }
#}

# Terraform Cloud backend configuration
data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "nimbusdevops"
    workspaces = {
      name = "tf-up-and-running2"
    }
  }
}

module "webserver-cluster" {
  source = "git::https://github.com/jakefurlong/modules.git//webserver-cluster?ref=v0.6.0"

  security_group_name         = "webservers-stage"
  asg_name                    = "asg-stage"
  lt_name                     = "launch-template-stage"
  template_instance_type      = "t2.micro"
  key_pair                    = "ndo-key-stage"
  instance_name_tag           = "ndo-web-stage"
  alb_name                    = "ndo-alb-stage"
  tg_name                     = "ndo-tg-stage"
  sg_name_tag                 = "allowHTTPstage"
  asg_desired                 = "2"
  asg_min                     = "2"
  asg_max                     = "3"
  enable_autoscaling_schedule = false
  custom_tags = {
    Environment = "Stage"
    DeployedBy  = "Terraform"
    Project     = "Aardvark"
  }
}