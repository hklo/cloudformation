provider "aws" {
  region = "${var.aws_region}"
}

module "task-def" {
  source = "modules/task-definitions"
}
