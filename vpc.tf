# VPCの作成
resource "aws_vpc" "web-site-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "web-site-vpc"
  }
}

#インターネットゲートウェイ
resource "aws_internet_gateway" "web-site-igw" {
  vpc_id = aws_vpc.web-site-vpc.id
  tags = {
    Name = "web-site-igw"
  }
}

# パブリックサブネット1a
resource "aws_subnet" "web-site-public_1a" {
  vpc_id = aws_vpc.web-site-vpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "web-site-public_1a"
  }
}

# パブリックサブネット1c
resource "aws_subnet" "web-site-public_1c" {
  vpc_id = aws_vpc.web-site-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "web-site-public_1c"
  }
}

# プライベートサブネット1a
resource "aws_subnet" "web-site-private_1a" {
  vpc_id = aws_vpc.web-site-vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "web-site-private _1a"
  }
}

# プライベートサブネット1c
resource "aws_subnet" "web-site-private_1c" {
  vpc_id = aws_vpc.web-site-vpc.id
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "web-site-private _1c"
  }
}
