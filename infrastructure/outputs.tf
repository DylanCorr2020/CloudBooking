output "vpc_id" {
  description = "ID of project VPC"
  value       = aws_vpc.main.id
}


output "ec2_instance_1a" {

  description = "Values for EC2 instance"
  value = aws_instance.ec2-instance-1a.id
  
}


output "rds_instance" {

    description = "Values for RDS instance"
    value = aws_db_instance.rds-database.id
  
}


