module "vpc" {
  source   = "app.terraform.io/Darnold-Hashicorp/vpc/aws"
  version  = "1.0.1"
  vpc_cidr = "${var.vpc_cidr}"
}

module "public-subnet" {
  source            = "app.terraform.io/Darnold-Hashicorp/public-subnet/aws"
  version           = "1.0.1"
  vpc_id            = "${module.vpc.vpc_id}"
  route_table_id    = "${module.vpc.route_table_id}"
  availability_zone = "${var.availability_zone}"
  network_name      = "${var.network_name}"
  subnet_cidr       = "${var.public_subnet_cidr}"
}

module "private-subnet" {
  source            = "app.terraform.io/Darnold-Hashicorp/private-subnet/aws"
  version           = "1.0.2"
  vpc_id            = "${module.vpc.vpc_id}"
  public_subnet_id  = "${module.public-subnet.subnet_id}"
  availability_zone = "${var.availability_zone}"
  network_name      = "${var.network_name}"
  subnet_cidr       = "${var.private_subnet_cidr}"
}

module "bastion" {
  source           = "app.terraform.io/Darnold-Hashicorp/bastion/aws"
  version          = "1.0.2"
  admin_sg         = "${module.private-subnet.admin_sg}"
  cluster_name     = "${var.network_name}"
  key_name         = "${var.key_name}"
  public_subnet_id = "${module.public-subnet.subnet_id}"
  ssh_access       = "0.0.0.0/0"
  vpc_id           = "${module.vpc.vpc_id}"
}
