#----root/main.tf-----
provider "aws" {
  region = var.aws_region
}

# Deploy Networking Resources
module "Networking" {
  source            = "./Networking"
  cidr              = "${var.cidr}"
  vpc-subnets-count = "${var.vpc-subnets-count}"
  cluster-name      = "${var.cluster-name}"
}

# Deploy Compute Resources
module "Compute" {
  source                       = "./Compute"
  bastion-server-instance-type = "${var.bastion-server-instance-type}"
  cluster-name                 = "${var.cluster-name}"
  key_name                     = "${var.key_name}"
  aws_subnet                   = "${module.Networking.public_subnet}"
  vpc_id                       = "${module.Networking.VPC}"
}

# Deploy EKS cluster
module "EKS" {
  source                = "./EKS"
  cluster-name          = "${var.cluster-name}"
  eks-securitygroup     = "${var.eks-securitygroup}"
  eks-cluster-role-name = "${var.eks-cluster-role-name}"
  vpc_id                = "${module.Networking.VPC}"
  aws_subnets           = "${module.Networking.public_subnet}"
}

#Deploy workernode
module "workernodes" {
  source                 = "./workernodes"
  eks-node-role-name     = "${var.eks-node-role-name}"
  spot_price             = "${var.spot_price}"
  key_name               = "${var.key_name}"
  node-instance-profile  = "${var.node-instance-profile}"
  eks-node-securitygroup = "${var.eks-node-securitygroup}"
  arn                    = "${module.workernodes.arn}"
  vpc_id                 = "${module.Networking.VPC}"
  aws_subnet             = "${module.Networking.public_subnet}"
  cluster-name           = "${module.EKS.cluster-name}"
  eks-securitygroup      = "${module.EKS.eks-securitygroup}"
  endpoint               = "${module.EKS.endpoint}"
  certificate            = "${module.EKS.kubeconfig-certificate-authority-data}"
  worker_ami_name_filter = "${var.worker_ami_name_filter}"
  worker_ami_owner_id    = "${var.worker_ami_owner_id}"
  instance_type          = "${var.instance_type}"
  name_prefix            = "${var.name_prefix}"
  num-workers            = "${var.num-workers}"
  num-max-workers        = "${var.num-max-workers}"
  num-min-workers        = "${var.num-min-workers}"
  alb-name               = "${var.alb-name}"
}


#Deploy RDS
module "RDS" {
  source                = "./RDS"
  rds_allocated_storage = "${var.rds_allocated_storage}"
  rds_storage_type      = "${var.rds_storage_type}"
  rds_engine            = "${var.rds_engine}"
  rds_engine_version    = "${var.rds_engine_version}"
  rds_instance_class    = "${var.rds_instance_class}"
  rds_db_user           = "${var.rds_db_user}"
  rds_db_password       = "${var.rds_db_password}"
  db_name               = "${var.db_name}"
  cluster-name          = "${module.EKS.cluster-name}"
  aws_subnet            = "${module.Networking.public_subnet}"
  vpc_id                = "${module.Networking.VPC}"
  publicly_accessible   = "${var.publicly_accessible}"
}


# #Deploy Elasticsearch
# module "Elasticsearch" {
#   source = "./Elasticsearch"
#   create_iam_service_linked_role = "${var.create_iam_service_linked_role}"
#   enabled = "${var.enabled}"
#   # RoleName = "${var.RoleName}"
#   vpc_id = "${module.Networking.VPC}"
#   aws_subnet = "${module.Networking.public_subnet}"
#   cidr = "${module.Networking.VPC_CIDR}"
#   domain_name = "${var.domain_name}"
#   cluster-name = "${module.EKS.cluster-name}"
#   es_version = "${var.es_version}"
#   elastic_instance_type = "${var.elastic_instance_type}"
#   instance_count = "${var.instance_count}"
#   dedicated_master_type = "${var.dedicated_master_type}"
#   es_zone_awareness = "${var.es_zone_awareness}"
#   es_zone_awareness_count = "${var.es_zone_awareness_count}"
#   dedicated_master_threshold = "${var.dedicated_master_threshold}"
#   node_to_node_encryption_enabled = "${var.node_to_node_encryption_enabled}"
#   ebs_volume_size = "${var. ebs_volume_size}"
#   ebs_volume_type = "${var.ebs_volume_type}"
#   snapshot_start_hour = "${var.snapshot_start_hour}"
# }
