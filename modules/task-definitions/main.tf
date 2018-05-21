data "template_file" "task_definition" {
  template = "${file("${path.module}/task-definition.json")}"

  vars {
    image_url      = "275511194806.dkr.ecr.ap-southeast-1.amazonaws.com/candidate_profile:latest"
    container_name = "profile"
  }
}

resource "aws_ecs_task_definition" "service" {
  family                = "def-profile"
  container_definitions = "${data.template_file.task_definition.rendered}"

  volume {
    name      = "logs"
    host_path = "/logs/profile"
  }
}
