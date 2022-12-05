# EC2用のSG
resource "aws_security_group" "web-ec2-sg" {
  name        = "web-ec2-sg"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.web-site-vpc.id

  egress {
    description = "Allow ALL"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-ec2-sg"
  }
}

# インバウンドはALBのSGを別途指定
resource "aws_security_group_rule" "from-alb" {
  type                     = "ingress"
  description              = "Allow ALB"
  to_port                  = "80"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web-alb-sg.id
  from_port                = "80"
  security_group_id        = aws_security_group.web-ec2-sg.id
}

# RDS用のSG
resource "aws_security_group" "web-rds-sg" {
  name        = "web-rds-sg"
  description = "For RDS"
  vpc_id      = aws_vpc.web-site-vpc.id

  egress {
    description = "Allow All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "web-rds-sg"
  }
}
# インバウンドはEC2のSGを別途指定
resource "aws_security_group_rule" "from_web-server" {
  type                     = "ingress"
  description              = "Allow Web Server"
  to_port                  = "3306"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web-ec2-sg.id
  from_port                = "3306"
  security_group_id        = aws_security_group.web-rds-sg.id
}


# ALB用のセキュリティグループ
resource "aws_security_group" "web-alb-sg" {
  name        = "web-alb-sg"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.web-site-vpc.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow ALL"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-alb-sg"
  }

}
