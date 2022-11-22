# ---------------------------
# EC2
# ---------------------------
# Amazon Linux 2 の最新版AMIを取得
data "aws_ssm_parameter" "amzn2_latest_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# EC2作成 AZ: 1a
resource "aws_instance" "web-ec2-1a" {
  ami = data.aws_ssm_parameter.amzn2_latest_ami.value
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web-ec2-sg.id]
  subnet_id = aws_subnet.web-site-public_1a.id
  associate_public_ip_address = "true"
  iam_instance_profile = aws_iam_instance_profile.instance_role.id
  tags = {
    Name = "web-ec2-1a"
  }
}


# AMIの作成
# resource "aws_ami_from_instance" "web-ec2-ami" {
#   name               = "web-ec2-ami"
#   source_instance_id = "i-00b6dfdcbf643cdf6"
#   tags = {
#     "Name" = "web-ec2-ami"
#   }
# }
