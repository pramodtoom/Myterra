# resource "aws_iam_service_linked_role" "es" {
#   count            = var.enabled && var.create_iam_service_linked_role ? 1 : 0
#   aws_service_name = "es.amazonaws.com"
# }

# resource "aws_security_group" "es_sg" {
#   name = "${var.cluster-name}-${var.domain_name}-sg"
#   description = "Allow inbound traffic to ElasticSearch from VPC CIDR"
#   vpc_id = "${var.vpc_id}"

#   ingress {
#       from_port = 0
#       to_port = 0
#       protocol = "-1"
#       cidr_blocks = [
#           "${var.cidr}"
#       ]
#   }
# }



# resource "aws_elasticsearch_domain" "elasticsearch" {
#   depends_on            = ["aws_iam_service_linked_role.es"]
#   domain_name           = "${var.cluster-name}-${var.domain_name}"
#   elasticsearch_version = "${var.es_version}"

#   cluster_config {
#     instance_type            = "${var.elastic_instance_type}"
#     instance_count           = "${var.instance_count}"
#     dedicated_master_enabled = "${var.instance_count >= var.dedicated_master_threshold ? true : false}"
#     dedicated_master_count   = "${var.instance_count >= var.dedicated_master_threshold ? 3 : 0}"
#     dedicated_master_type    = "${var.instance_count >= var.dedicated_master_threshold ? (var.dedicated_master_type != "false" ? var.dedicated_master_type : var.elastic_instance_type) : ""}"
#     zone_awareness_enabled   = "${var.es_zone_awareness}"
#     zone_awareness_config {
#       availability_zone_count = "${var.es_zone_awareness_count}"
#     }
#   }

#   vpc_options {
#       subnet_ids = "${var.aws_subnet}"
#       security_group_ids = [
#           "${aws_security_group.es_sg.id}"
#       ]
#   }

#   node_to_node_encryption {
#     enabled = "${var.node_to_node_encryption_enabled}"
#   }

#   ebs_options {
#     ebs_enabled = "${var.ebs_volume_size > 0 ? true : false}"
#     volume_size = "${var.ebs_volume_size}"
#     volume_type = "${var.ebs_volume_type}"
#   }

#   snapshot_options {
#     automated_snapshot_start_hour = "${var.snapshot_start_hour}"
#   }

#   tags =  {
#     environment = "${var.cluster-name}-elasticsearch"
#   }
# }

# resource "aws_elasticsearch_domain_policy" "main" {
#   domain_name = "${aws_elasticsearch_domain.elasticsearch.domain_name}"

#   access_policies = <<POLICIES
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Action": "es:*",
#             "Principal": "*",
#             "Effect": "Allow",
#             "Resource": "${aws_elasticsearch_domain.elasticsearch.arn}/*"
#         }
#     ]
# }
# POLICIES
# }

