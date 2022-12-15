# 起動設定
resource "aws_launch_configuration" "web-launch-config" {
  name                        = "web-launch-config"
  image_id                    = aws_ami_from_instance.web-ec2-ami.id
  instance_type               = "t2.micro"
  iam_instance_profile        = aws_iam_instance_profile.instance_role.id
  security_groups             = [aws_security_group.web-ec2-sg.id]
  associate_public_ip_address = true
}

## スケーリンググループ
resource "aws_autoscaling_group" "web-asg-group" {
  name                      = "web-asg-group"
  launch_configuration      = aws_launch_configuration.web-launch-config.name
  vpc_zone_identifier       = [aws_subnet.web-site-public_1a.id, aws_subnet.web-site-public_1c.id]
  target_group_arns         = [aws_lb_target_group.web-alb-tg.arn]
  health_check_grace_period = 30
  health_check_type         = "ELB"
  desired_capacity          = 2
  min_size                  = 2
  max_size                  = 4
}

# スケーリングポリシー
resource "aws_autoscaling_policy" "web-asg-policy" {
  name                   = "web-asg-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.web-asg-group.name

  target_tracking_configuration {
    customized_metric_specification {
      namespace   = "AWS/EC2"
      metric_name = "CPUUtilization"
      statistic   = "Average"

      metric_dimension {
        name  = "AutoScalingGroupName"
        value = aws_autoscaling_group.web-asg-group.name
      }
    }
    target_value = 40.0
  }

}
