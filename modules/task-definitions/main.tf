locals {
  log_group_name = "${var.log_group_name != "" ? var.log_group_name : var.task_name}"
}

data "aws_region" "current" {}

data "template_file" "task_definition" {
  template = "${file("${var.task_definition_path}")}"

  vars = "${merge(
    var.params,
    map(
      "log_group_name", "${aws_cloudwatch_log_group.this.name}",
      "log_group_region", "${data.aws_region.current.name}"
    )
  )}"
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "${local.log_group_name}"
  retention_in_days = "${var.log_retention_in_days}"
}

resource "aws_ecs_task_definition" "this" {
  family                = "${var.task_name}"
  container_definitions = "${data.template_file.task_definition.rendered}"
}
