module "vpc" {
  source       = "app.terraform.io/Darnold-Hashicorp/vpc/aws"
  version      = "1.0.1"
  vpc_cidr     = "${var.vpc_cidr}"
  network_name = "${var.network_name}"
}

data "aws_availability_zones" "available" {}

module "public-subnet1" {
  source            = "app.terraform.io/Darnold-Hashicorp/public-subnet/aws"
  version           = "1.0.2"
  vpc_id            = "${module.vpc.vpc_id}"
  route_table_id    = "${module.vpc.route_table_id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  network_name      = "${var.network_name}-${data.aws_availability_zones.available.names[0]}"
  subnet_cidr       = "${var.public_subnet_cidr1}"
}

module "public-subnet2" {
  source            = "app.terraform.io/Darnold-Hashicorp/public-subnet/aws"
  version           = "1.0.2"
  vpc_id            = "${module.vpc.vpc_id}"
  route_table_id    = "${module.vpc.route_table_id}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  network_name      = "${var.network_name}-${data.aws_availability_zones.available.names[1]}"
  subnet_cidr       = "${var.public_subnet_cidr2}"
}

module "private-subnet1" {
  source            = "app.terraform.io/Darnold-Hashicorp/private-subnet/aws"
  version           = "1.0.2"
  vpc_id            = "${module.vpc.vpc_id}"
  public_subnet_id  = "${module.public-subnet1.subnet_id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  network_name      = "${var.network_name}-${data.aws_availability_zones.available.names[0]}"
  subnet_cidr       = "${var.private_subnet_cidr1}"
}

module "private-subnet2" {
  source            = "app.terraform.io/Darnold-Hashicorp/private-subnet/aws"
  version           = "1.0.2"
  vpc_id            = "${module.vpc.vpc_id}"
  public_subnet_id  = "${module.public-subnet2.subnet_id}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  network_name      = "${var.network_name}-${data.aws_availability_zones.available.names[1]}"
  subnet_cidr       = "${var.private_subnet_cidr2}"
}

module "bastion1" {
  source           = "app.terraform.io/Darnold-Hashicorp/bastion/aws"
  version          = "1.0.7"
  admin_sg         = "${module.private-subnet1.admin_sg}"
  network_name     = "${var.network_name}"
  key_name         = "${var.key_name}"
  public_subnet_id = "${module.public-subnet1.subnet_id}"
  ssh_access       = "0.0.0.0/0"
  vpc_id           = "${module.vpc.vpc_id}"
}

module "bastion2" {
  source           = "app.terraform.io/Darnold-Hashicorp/bastion/aws"
  version          = "1.0.7"
  admin_sg         = "${module.private-subnet1.admin_sg}"
  network_name     = "${var.network_name}"
  key_name         = "${var.key_name}"
  public_subnet_id = "${module.public-subnet1.subnet_id}"
  ssh_access       = "0.0.0.0/0"
  vpc_id           = "${module.vpc.vpc_id}"
}
