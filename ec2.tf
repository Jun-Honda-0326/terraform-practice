# # ---------------------------
# # EC2
# # ---------------------------
# # Amazon Linux 2 の最新版AMIを取得
# data "aws_ssm_parameter" "amzn2_latest_ami" {
#   name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
# }

# # EC2作成 AZ: 1a
# resource "aws_instance" "web-ec2-1a" {
#   ami                         = data.aws_ssm_parameter.amzn2_latest_ami.value
#   instance_type               = "t2.micro"
#   vpc_security_group_ids      = [aws_security_group.web-ec2-sg.id]
#   subnet_id                   = aws_subnet.web-site-public_1a.id
#   associate_public_ip_address = "true"
#   iam_instance_profile        = aws_iam_instance_profile.instance_role.id
#   tags = {
#     Name = "web-ec2-1a"
#   }

#   user_data = <<EOF
#   #!/bin/bash

#     ### install appach
#     yum install httpd -y
#     systemctl start httpd
#     systemctl enable httpd

#     ### install php
#     amazon-linux-extras install php7.2
#     yum install -y php

#     ### install wordpress
#     wget http://ja.wordpress.org/latest-ja.tar.gz
#     tar -xzvf latest-ja.tar.gz

#     cp -r wordpress/* /var/www/html
#     chown apache:apache /var/www/html/ -R
#     systemctl restart httpd.service

#     EOF

# }

# # AMIの作成
# resource "aws_ami_from_instance" "web-ec2-ami" {
#   name               = "web-ec2-ami"
#   source_instance_id = "i-0f36ee165bcd44175"
#   tags = {
#     "Name" = "web-ec2-ami"
#   }
# }

# # EC2作成 1c
# resource "aws_instance" "web-ec2-1c" {
#   ami                         = aws_ami_from_instance.web-ec2-ami.id
#   instance_type               = "t2.micro"
#   vpc_security_group_ids      = [aws_security_group.web-ec2-sg.id]
#   subnet_id                   = aws_subnet.web-site-public_1c.id
#   associate_public_ip_address = "true"
#   iam_instance_profile        = aws_iam_instance_profile.instance_role.id
#   tags = {
#     Name = "web-ec2-1c"
#   }
# }
