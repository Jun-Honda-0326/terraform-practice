# EC2用のSG
resource "aws_security_group" "web-ec2-sg" {
  name        = "web-ec2-sg"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.web-site-vpc.id

  ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow ALL"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-ec2-sg"
  }

}
