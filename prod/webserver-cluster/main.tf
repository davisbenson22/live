provider "aws" {
  region = "us-west-1"
}

terraform {
  backend "s3" {
    bucket = "nimbusdevops"
    key    = "terraform-state/prod/web/terraform.tfstate"
    region = "us-west-1"

    dynamodb_table = "tf-locks-prod-web"
    encrypt        = true
  }
}

module "webserver-cluster" {
  #source = "../../modules/webserver-cluster"
  source = "https://github.com/jakefurlong/webserver-cluster//webserver-cluster?ref=v.0.0.1"
  

  security_group_name    = "webservers-prod"
  asg_name               = "asg-prod"
  lt_name                = "launch-template-prod"
  template_instance_type = "t2.micro"
  key_pair               = "ndo-key-prod"
  instance_name_tag      = "ndo-web-prod"
  alb_name               = "ndo-alb-prod"
  tg_name                = "ndo-tg-prod"
  sg_name_tag            = "allowHTTPprod"
  asg_desired            = "2"
  asg_min                = "2"
  asg_max                = "3"
}