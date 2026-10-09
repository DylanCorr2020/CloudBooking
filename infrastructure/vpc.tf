

#main VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    name = "Main VPC"
  }

}

#Public Subnet where is EC2 will be running 
resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.main.id
  map_public_ip_on_launch = true
  cidr_block = "10.0.1.0/24"

  tags = {
    name = "Public Subnet"
  }
}

#Private Subnet where RDS intsance will be running 
resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    name = "Private Subnet"
  }
}


#Internet Gateway 

resource "aws_internet_gateway" "igw" {
   
   vpc_id = aws_vpc.main.id

   tags = {
      name = "Internet Gateway"
   }
   
}


# created route table for internet gateway to connect public subnet
resource "aws_route_table" "route-table-igw" {
    
    vpc_id = aws_vpc.main.id
    
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  
}


resource "aws_route_table_association" "route-table-association-igw" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.route-table-igw.id
}