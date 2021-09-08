provider "aws" {
  region = "us-east-2"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "allow ssh traffic"

  ingress = [
    {
      description       = "ssh traffic"
      from_port         = 22
      to_port           = 22
      protocol          = "TCP"
      cidr_blocks       = ["0.0.0.0/0"]
      ipv6_cidr_blocks  = null
      prefix_list_ids   = null
      security_groups   = null
      self              = null
    }
  ]

  egress = [
    {
      description       = "egress traffic"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks       = ["0.0.0.0/0"]
      ipv6_cidr_blocks  = null
      prefix_list_ids   = null
      security_groups   = null
      self              = null
    }
  ]
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "allow http traffic"

  ingress = [
    {
      description       = "http traffic"
      from_port         = 80
      to_port           = 80
      protocol          = "TCP"
      cidr_blocks       = ["0.0.0.0/0"]
      ipv6_cidr_blocks  = null
      prefix_list_ids   = null
      security_groups   = null
      self              = null
    }
  ]

  egress = [
    {
      description       = "egress traffic"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks       = ["0.0.0.0/0"]
      ipv6_cidr_blocks  = null
      prefix_list_ids   = null
      security_groups   = null
      self              = null
    }
  ]
}

resource "aws_key_pair" "mykeypair22" {
    key_name = "mykeypair22"
    public_key = var.public_key
}