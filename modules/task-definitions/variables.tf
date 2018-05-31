variable "params" {
  default = {
  }
}

variable "log_retention_in_days" {
  default = "30"
}

variable "log_group_name" {
  default = ""
}

variable "log_stream_prefix" {
  default = ""
}

variable "task_definition_path" {}

variable "task_name" {}
