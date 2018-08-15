variable "vpc_cidr" {
  default = "10.20.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.20.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.20.2.0/24"
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
