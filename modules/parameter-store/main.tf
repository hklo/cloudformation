resource "aws_kms_key" "this" {
  description             = "KMS key 1"
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "this" {
  name          = "alias/my-ecs"
  target_key_id = "${aws_kms_key.this.key_id}"
}

resource "aws_ssm_parameter" "secret" {
  name        = "test-secret"
  description = "The parameter description"
  type        = "SecureString"
  value       = "haha"
  key_id      = "${aws_kms_alias.this.name}"
}
