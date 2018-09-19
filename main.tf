module "vpc" {
  source       = "github.com/HappyPathway/terraform-aws-vpc"
  version      = "1.0.1"
  vpc_cidr     = "${var.vpc_cidr}"
  network_name = "${var.network_name}"
}

module "public-subnet" {
  source            = "github.com/HappyPathway/terraform-aws-public-subnet"
  version           = "1.0.2"
  vpc_id            = "${module.vpc.vpc_id}"
  route_table_id    = "${module.vpc.route_table_id}"
  availability_zone = "${var.availability_zone}"
  network_name      = "${var.network_name}"
  subnet_cidr       = "${var.public_subnet_cidr}"
}

module "private-subnet" {
  source            = "github.com/HappyPathway/terraform-aws-private-subnet"
  version           = "1.0.2"
  vpc_id            = "${module.vpc.vpc_id}"
  public_subnet_id  = "${module.public-subnet.subnet_id}"
  availability_zone = "${var.availability_zone}"
  network_name      = "${var.network_name}"
  subnet_cidr       = "${var.private_subnet_cidr}"
}

module "bastion" {
  source           = "github.com/HappyPathway/terraform-aws-bastion"
  version          = "1.0.2"
  admin_sg         = "${module.private-subnet.admin_sg}"
  cluster_name     = "${var.network_name}"
  key_name         = "${var.key_name}"
  public_subnet_id = "${module.public-subnet.subnet_id}"
  ssh_access       = "0.0.0.0/0"
  vpc_id           = "${module.vpc.vpc_id}"
}
