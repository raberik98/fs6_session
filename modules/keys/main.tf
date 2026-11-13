locals {
  public_key = var.key.key_string != "" ? var.key.key_string : file(var.key.key_path)
}

resource "aws_key_pair" "this" {
    key_name   = var.key.name
    public_key = local.public_key
}
