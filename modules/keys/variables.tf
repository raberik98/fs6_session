variable "key" {
  description = "Fill either the key_path or the key_string."
  type = object({
    name = string
    key_path = optional(string, "")
    key_string = optional(string, "")
  })

  validation {
    condition = alltrue([
      var.key.name != "",
      (var.key.key_path == "") != (var.key.key_string == ""),
      var.key.key_path != "" ? try(file(var.key.key_path), "") != "" : true,
      var.key.key_path != null && var.key.key_string != null
    ])

error_message = <<EOT
%{ if var.key.name == "" ~}
Name can't be an empty string.
%{ endif }
%{ if (var.key.key_path == "") == (var.key.key_string == "") ~}
You must fill either the key_path or key_string value.
%{ endif }
%{ if var.key.key_path != "" ? try(file(var.key.key_path), "") == "" : false ~}
Invalid file path: ${var.key.key_path}
%{ endif }
%{ if var.key.key_path != null && var.key.key_string != null ~}
Key_path and key_string can't be both null.
%{ endif }
EOT
  }
}