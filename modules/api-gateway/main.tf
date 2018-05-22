resource "aws_api_gateway_rest_api" "api" {
  name        = "${var.ag_name}"
  description = "API gateway to handle ecs services with VPC link enabled"
}

resource "aws_api_gateway_resource" "v1" {
  path_part   = "v1"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
}

resource "aws_api_gateway_resource" "proxy" {
  path_part   = "{proxy+}"
  parent_id   = "${aws_api_gateway_resource.v1.id}"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
}

resource "aws_api_gateway_method" "any" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  resource_id = "${aws_api_gateway_resource.proxy.id}"
  http_method = "ANY"

  authorization = "NONE"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "proxy" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  resource_id = "${aws_api_gateway_resource.proxy.id}"
  http_method = "${aws_api_gateway_method.any.http_method}"

  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  type                    = "HTTP_PROXY"
  uri                     = "${var.nlb_uri}"
  integration_http_method = "ANY"

  connection_type = "VPC_LINK"
  connection_id   = "${var.vpc_link_id}"
}

resource "aws_api_gateway_deployment" "deploy" {
  depends_on = ["aws_api_gateway_integration.proxy"]

  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name  = "${var.ag_stage_name}"
}
