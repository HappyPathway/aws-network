output "admin_sg" {
  value       = "${module.private_subnet.admin_sg}"
  description = "Security Group ID for Admin SG"
}

output "public_subnet" {
  value       = "${module.public_subnet.subnet_id}"
  description = "Public Subnet ID"
}

output "private_subnet" {
  value       = "${module.private_subnet.subnet_id}"
  description = "Private Subnet ID"
}

output "bastion_host" {
  value       = "${module.bastion.bastion_host}"
  description = "IP Address of Bastion Host"
}

output "key_name" {
  value = "${module.bastion.key_name}"
}
