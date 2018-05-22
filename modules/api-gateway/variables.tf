variable "ag_name" {
  description = "API Gateway name"
}

variable "nlb_uri" {
  description = "NLB endpoint to integrate with VPC Link"
}

variable "vpc_link_id" {
  description = "VPC link id to used at API Gateway"
}

variable "ag_stage_name" {
  description = "API gateway deployment stage name"
}
