variable "name" { type = string }
variable "key_string" { 
    type = string
    description = "Public as a string."

    validation {
      condition = var.key_string != ""
      error_message = "Invalid public key: ${var.key_string == "" ? "<empty string>" : var.key_string}"
    }
}