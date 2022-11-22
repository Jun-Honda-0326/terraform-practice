# IAMロールの作成
resource "aws_iam_role" "access-ssm-role-for-ec2" {
  name = "access-ssm-role-for-ec2"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# IAMロールにポリシーをアタッチ
resource "aws_iam_role_policy_attachment" "access-ssm-role-for-ec2-attach" {
  role       = aws_iam_role.access-ssm-role-for-ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "instance_role" {
  name = "web-ec2-instance-role"
  role = aws_iam_role.access-ssm-role-for-ec2.name
}
