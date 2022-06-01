data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "bastion-server" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "${var.bastion-server-instance-type}"
  vpc_security_group_ids      = [aws_security_group.bastion-sg.id]
  key_name                    = "${var.key_name}"
  subnet_id                   = "${var.aws_subnet[0]}"
  associate_public_ip_address = "1"
  
  tags = {
    Name = "${var.cluster-name}-bastion-server"
  }
}

resource "aws_security_group" "bastion-sg" {
name = "${var.cluster-name}_bastionsg"
vpc_id = "${var.vpc_id}"
ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
from_port = 22
    to_port = 22
    protocol = "tcp"
  }
// Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}



