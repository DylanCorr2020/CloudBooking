


resource "aws_security_group" "rds-security-group" {
  name        = "rds_security_group"
  description = "Allow inbound traffic only for MySQL and allow all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "rds-secuirty-group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds-allow-inbound-traffic-MYSQL" {
  security_group_id = aws_security_group.rds-security-group.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

resource "aws_vpc_security_group_ingress_rule" "rds-allow-inbound-traffic-HTTP" {
  security_group_id = aws_security_group.rds-security-group.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "rds-allow-all-outbound-traffic" {
  security_group_id = aws_security_group.rds-security-group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}