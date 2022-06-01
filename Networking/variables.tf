#----networking/variables.tf----

variable "cidr" {}

data "aws_availability_zones" "available" {}

variable "cluster-name" {}

variable "vpc-subnets-count" {}

