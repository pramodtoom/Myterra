#----root/variables.tf-----#
variable "aws_region" {}

# -------- Networking Variables ---------#

variable "cidr" {}
variable "vpc-subnets-count" {}

# ------------------ compute variables----------
variable "bastion-server-instance-type" {}
variable "key_name" {}

#----EKS variables.tf----
variable "cluster-name" {}
variable "eks-cluster-role-name" {}
variable "eks-securitygroup" {}

#----workernodes variables.tf----
variable "eks-node-role-name" {}
variable "node-instance-profile" {}
variable "eks-node-securitygroup" {}
variable "instance_type" {}

variable "worker_ami_name_filter" {}
variable "worker_ami_owner_id" {}
variable "name_prefix" {}

variable "num-workers" {}
variable "num-max-workers" {}
variable "num-min-workers" {}
variable "alb-name" {}
variable "spot_price" {}

#---- RDS variables.tf----
variable "rds_allocated_storage" {}
variable "rds_storage_type" {}
variable "rds_engine" {}
variable "rds_engine_version" {}
variable "rds_instance_class" {}
variable "rds_db_user" {}
variable "rds_db_password" {}
variable "db_name" {}
variable "publicly_accessible" {}

# #---- Elasticsearch variables.tf----
# variable "create_iam_service_linked_role" {}
# variable "enabled" {}
# # variable "RoleName" {}
# variable "domain_name" {}
# variable "es_version" {}
# variable "elastic_instance_type" {}
# variable "instance_count" {}
# variable "dedicated_master_type" {}
# variable "es_zone_awareness" {}
# variable "es_zone_awareness_count" {}
# variable "dedicated_master_threshold" {}
# variable "node_to_node_encryption_enabled" {}
# variable "ebs_volume_size" {}
# variable "ebs_volume_type" {}
# variable "snapshot_start_hour" {}
