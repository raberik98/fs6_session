variable "vpc_id" {
  type = string
}

variable "instances" {
  type = list(object({
    name = string
    key_name = string
    subnet_id = string
    type = string
  }))
}