

#====================== Secuirty Group for EC2 ===================================

resource "aws_security_group" "ec2-security-group" {
  name        = "ec2_security_group"
  description = "Allow inbound traffic only for HTTP on port 80 all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "ec2-secuirty-group"
  }
}

# Allow inbound HTTP traffic 
resource "aws_vpc_security_group_ingress_rule" "ec2-allow-inbound-traffic-HTTP" {
  security_group_id = aws_security_group.ec2-security-group.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


#Allow all outbound traffic 
resource "aws_vpc_security_group_egress_rule" "ec2-allow-all-outbound-traffic" {
  security_group_id = aws_security_group.ec2-security-group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}




# =================== Security group for RDS ============================================
resource "aws_security_group" "rds-security-group" {
  name        = "rds_security_group"
  description = "RDS database security group to allow EC2 instance to securely connect to RDS database."
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "rds-secuirty-group"
  }
}


#resource "aws_vpc_security_group_ingress_rule" "rds-allow-inbound-traffic-MYSQL" {
  #security_group_id = aws_security_group.rds-security-group.id
  #cidr_ipv4         = aws_vpc.main.cidr_block
  #from_port         = 3306
  #ip_protocol       = "tcp"
  #to_port           = 3306
  
#}

#Create ingress rule to allow EC2 Security Group to connect to RDS
resource "aws_security_group_rule" "ingress" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ec2-security-group.id
  security_group_id        = aws_security_group.rds-security-group.id
}


