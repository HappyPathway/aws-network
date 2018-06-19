module "vpc" {
  source   = "app.terraform.io/Darnold-Hashicorp/vpc/aws"
  version  = "${var.vpc_version}"
  vpc_cidr = "${var.vpc_cidr}"
}

module "public-subnet" {
  source            = "app.terraform.io/Darnold-Hashicorp/public-subnet/aws"
  version           = "${var.public_subnet_version}"
  subnet_name       = "${var.network_name}-public"
  vpc_id            = "${module.vpc.vpc_id}"
  route_table_id    = "${module.vpc.route_table_id}"
  availability_zone = "${var.availability_zone}"
  cluster_name      = "${var.network_name}"
  subnet_cidr       = "10.0.1.0/24"
}

module "private-subnet" {
  source            = "app.terraform.io/Darnold-Hashicorp/private-subnet/aws"
  version           = "${var.private_subnet_version}"
  subnet_name       = "${var.network_name}-private"
  vpc_id            = "${module.vpc.vpc_id}"
  public_subnet_id  = "${module.public-subnet.subnet_id}"
  availability_zone = "${var.availability_zone}"
  cluster_name      = "${var.network_name}"
  subnet_cidr       = "10.0.2.0/24"
}

module "bastion" {
  source           = "app.terraform.io/Darnold-Hashicorp/bastion/aws"
  version          = "${var.bastion_version}"
  admin_sg         = "${module.private_subnet.admin_sg}"
  cluster_name     = "${var.network_name}"
  key_name         = "${var.key_name}"
  public_subnet_id = "${module.public-subnet.subnet_id}"
}
