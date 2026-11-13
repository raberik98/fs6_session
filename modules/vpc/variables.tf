variable "name" { type = string }
variable "cidr_block" { type = string }
variable "tags" { type = map(string) }
variable "NAT_subnet" { type = string }

variable "subnets" {
  type = list(object({
    name       = string
    cidr_block = string
    type       = string # public | private | db 
    az         = string

    tags = optional(map(string), {})
  }))
}
