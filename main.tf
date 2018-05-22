provider "aws" {
  region = "${var.aws_region}"
}

module "api-gateway" {
  source = "modules/api-gateway"

  ag_name       = "bricks-api"
  nlb_uri       = "${var.nlb_uri}"
  vpc_link_id   = "${var.vpc_link_id}"
  ag_stage_name = "stage"
}
