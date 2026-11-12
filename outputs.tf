# output "ssh_commands" {
#   value = [ 
#     for ec2 in module.ec2.instances :
#         "ssh -i ./keys/${ec2.key_name} ubuntu@${ec2.ec2.public_ip} \n"
#     ]
# }

output "ssh_commands" {
  value = <<EOT
#!/usr/bin/env bash

%{ for ec2 in module.ec2.instances ~}
ssh -i ./keys/${ec2.key_name} ubuntu@${ec2.ec2.public_ip}
%{ endfor }
EOT
}