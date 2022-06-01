# ---------Compute outputs ---------

output "bastion_server-id" {
  value = "${aws_instance.bastion-server.id}"
}

output "bastion-public-ip" {
  value = "${aws_instance.bastion-server.public_ip}"
}
