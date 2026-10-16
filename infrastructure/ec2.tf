

# Created an EC2 instance
# T2 mirco
# Linux OS
# Attached public-subnet-1a
# Attached secuirty group to allow inbound traffic from HTTP
# Attached IAM role ec2_ssm_role so ec2 
resource "aws_instance" "ec2-instance-1a" {

  ami           = "ami-087fc0fcee2c7570a"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public-subnet-1a.id

  vpc_security_group_ids = [aws_security_group.ec2-security-group.id]

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name



}


resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_ssm_role.name
}
