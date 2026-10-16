

#Created RDS instance 
resource "aws_db_instance" "rds-database" {
  allocated_storage    = 10
  db_name              = "Bookings"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             =  var.db_password
  vpc_security_group_ids = [aws_security_group.rds-security-group.id]
  db_subnet_group_name = "subnet_rds_group"
  skip_final_snapshot  = true
}


# Created two private subnets for RDS 
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "subnet_rds_group"
  region = "eu-west-1"
  subnet_ids = [aws_subnet.private-subnet-1a.id , aws_subnet.private-subnet-1b.id]
  tags = {
    Name = "rds_subnet_group"
  }
}