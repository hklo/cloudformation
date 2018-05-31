provider "aws" {
  region = "${var.region}"
}

module "task-def" {
  source = "modules/task-definitions"

  params = {
    image_url         = "275511194806.dkr.ecr.ap-southeast-1.amazonaws.com/candidate_profile:123"
    container_name    = "profile"
    log_stream_prefix = "x"
  }

  task_definition_path = "config/task-definition/sample.json"
  task_name            = "test-task"
}
