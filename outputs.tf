output "admin_sg" {
  value       = "${module.private-subnet.admin_sg}"
  description = "Security Group ID for Admin SG"
}

output "public_subnet" {
  value       = "${module.public-subnet.subnet_id}"
  description = "Public Subnet ID"
}

output "private_subnet" {
  value       = "${module.private-subnet.subnet_id}"
  description = "Private Subnet ID"
}

output "bastion_host" {
  value       = "${module.bastion.bastion_host}"
  description = "IP Address of Bastion Host"
}

output "key_name" {
  value = "${module.bastion.key_name}"
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}
