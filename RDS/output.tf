output "sg_rds_id" {
  value = "${aws_security_group.rds.id}"
}
output "sg_rds_name" {
  value = "${aws_security_group.rds.name}"
}

output "rds_instance_name" {
  value = "${aws_db_instance.rds.name}"
}

output "rds_instance_id" {
  value = "${aws_db_instance.rds.id}"
}
