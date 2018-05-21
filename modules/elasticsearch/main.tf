data "template_file" "es_access_policy" {
  template = "${file("${path.module}/policy.json")}"
}

resource "aws_elasticsearch_domain" "es" {
  domain_name           = "tf-test"
  elasticsearch_version = "6.2"

  cluster_config {
    instance_type = "t2.medium.elasticsearch"
  }

  advanced_options {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  access_policies = "${data.template_file.es_access_policy.rendered}"

  tags {
    Environment = "Non-Production"
    Application = "AWS-ES"
  }
}

