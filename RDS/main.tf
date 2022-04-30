resource "aws_db_subnet_group" "rds_subnet" {
  subnet_ids          =  "${var.aws_subnet}"
  name                = "${var.cluster-name}-${var.db_name}-subnet"
}


resource "aws_security_group" "rds" {
    name        = "${var.cluster-name}-${var.db_name}-sg"
    vpc_id      = "${var.vpc_id}"

}

resource "aws_security_group_rule" "rds-ingress-all" {
    type        = "ingress"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.rds.id}"
}

resource "aws_security_group_rule" "rds-egress-all" {
    type        = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.rds.id}"
}

resource "aws_db_instance" "rds" {
  allocated_storage       = "${var.rds_allocated_storage}"
  storage_type            = "${var.rds_storage_type}"
  engine                  = "${var.rds_engine}"
  engine_version          = "${var.rds_engine_version}"
  instance_class          = "${var.rds_instance_class}"
  name                    = "${var.cluster-name}_${var.db_name}"
  username                = "${var.rds_db_user}"
  password                = "${var.rds_db_password}"
  publicly_accessible     = "${var.publicly_accessible}"
  multi_az                = false
  skip_final_snapshot     = true
  identifier              = "${var.cluster-name}-${var.db_name}-data"
  db_subnet_group_name    = "${aws_db_subnet_group.rds_subnet.name}"
  vpc_security_group_ids  = ["${aws_security_group.rds.id}"]

  tags = {
    Name      = "${var.cluster-name}.${var.db_name}"
  }
}

