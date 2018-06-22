variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr1" {
  default = "10.0.1.0/24"
}

variable "public_subnet_cidr2" {
  default = "10.0.3.0/24"
}

variable "private_subnet_cidr1" {
  default = "10.0.2.0/24"
}

variable "private_subnet_cidr2" {
  default = "10.0.4.0/24"
}

variable "network_name" {
  type        = "string"
  description = "Specify the name of the network"
}

variable "key_name" {
  type        = "string"
  description = "Specify AWS KeyPair"
}

variable "availability_zone" {
  type        = "string"
  description = "AZ where resources will live"
}

variable "region" {
  type        = "string"
  description = "Region where resources will live"
}
