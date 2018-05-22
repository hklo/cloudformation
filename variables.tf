variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "ap-southeast-1"
}

variable "nlb_uri" {
  description = "Network load balancer endpoint uri"
}

variable "vpc_link_id" {
  description = "API Gateway VPC link id"
}
