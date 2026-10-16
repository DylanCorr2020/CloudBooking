## Create Role to SSM into EC2 Instances 
resource "aws_iam_role" "ec2_ssm_role" {
  name = "ec2-ssm-role-cloud-booking"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}


# Attach policy to ec2_ssm_role to connect to EC2 via SSM 
resource "aws_iam_role_policy_attachment" "ssm_policy_ec2_cloud-booking" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
