output "endpoint" {
  value = "${aws_eks_cluster.main.endpoint}"
}

output "cluster_id" {
  value       = "${aws_eks_cluster.main.id}"
}


output "eks-securitygroup" {
  value       = "${aws_security_group.eks.id}"
}


output "cluster-name" {
  value       = "${aws_eks_cluster.main.name}"
}
output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.main.certificate_authority.0.data}"
}
