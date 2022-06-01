#----root/outputs.tf-----

# ----------------Networking outputs ---------------

output "VPC" {
  value = "${module.Networking.VPC}"
}

output "VPC_CIDR" {
  value = "${module.Networking.VPC_CIDR}"
}

output "public_subnet" {
  value = "${module.Networking.public_subnet}"
}


output "public_subnet_ip" {
  value = "${module.Networking.public_subnet_ip}"
}

output "internet_gateway_id" {
  value = "${module.Networking.IGW}"
}

# ---------Compute outputs ---------

output "bastion_server-id" {
  value = "${module.Compute.bastion_server-id}"
}

output "bastion-public-ip" {
  value = "${module.Compute.bastion-public-ip}"
}

# -----------EKS outputs ------------

output "endpoint" {
  value = "${module.EKS.endpoint}"
}

output "cluster_id" {
  value = "${module.EKS.cluster_id}"
}

output "cluster-name" {
  value = "${module.EKS.cluster-name}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${module.EKS.kubeconfig-certificate-authority-data}"
}

output "arn" {
  value = "${module.workernodes.arn}"
}


locals {
  config_map_aws_auth = <<CONFIGMAPAWSAUTH
  
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: "${module.workernodes.arn}"
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
  mapUsers: |
    - userarn: arn:aws:iam::882719166652:user/jitendra
      username: jitendra
      groups:
        - system:masters
CONFIGMAPAWSAUTH

  kubeconfig = <<KUBECONFIG


apiVersion: v1
clusters:
- cluster:
    server: ${module.EKS.endpoint}
    certificate-authority-data: ${module.EKS.kubeconfig-certificate-authority-data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${module.EKS.cluster-name}"
KUBECONFIG
}

output "config_map_aws_auth" {
  value = "${local.config_map_aws_auth}"
}

output "kubeconfig" {
  value = "${local.kubeconfig}"
}


# -----------RDS outputs ------------

output "sg_rds_id" {
  value = "${module.RDS.sg_rds_id}"
}
output "sg_rds_name" {
  value = "${module.RDS.sg_rds_name}"
}

output "rds_instance_name" {
  value = "${module.RDS.rds_instance_name}"
}

output "rds_instance_id" {
  value = "${module.RDS.rds_instance_id}"
}

# -----------Elasticsearch outputs ------------

# output "elasticsearch-arn" {
#   description = "Amazon Resource Name (ARN) of the domain"
#   value       = "${module.Elasticsearch.elasticsearch-arn}"
# }

# output "domain_id" {
#   description = "Unique identifier for the domain"
#   value       = "${module.Elasticsearch.domain_id}"
# }

# output "domain_name" {
#   description = "The name of the Elasticsearch domain"
#   value       = "${module.Elasticsearch.domain_name}"
# }

# output "elasticsearch-endpoint" {
#   description = "Domain-specific endpoint used to submit index, search, and data upload requests"
#   value       = "${module.Elasticsearch.elasticsearch-endpoint}"
# }

# output "kibana_endpoint" {
#   description = "Domain-specific endpoint for kibana without https scheme"
#   value       = "${module.Elasticsearch.kibana_endpoint}"
# }
