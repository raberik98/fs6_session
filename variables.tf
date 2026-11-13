variable "aws_region" { type = string }
variable "aws_profile" { type = string }

variable "vpc" {
  type = object({
    name       = string
    cidr_block = string

    tags       = optional(map(string), {})
    NAT_subnet = optional(string, "")

    subnets = list(object({
      name       = string
      cidr_block = string
      type       = string # public | private | db 
      az         = string

      tags = optional(map(string), {})
    }))
  })
}

variable "keys" {
  type = list(object({
    name       = string
    key_string = optional(string, "")
    key_path   = optional(string, "")
  }))
}

variable "ec2_instances" {
  type = list(object({
    name        = string
    key_name    = string
    subnet_name = string
    type        = string
  }))
}
