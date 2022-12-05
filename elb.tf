# ターゲットグループの作成
resource "aws_lb_target_group" "web-alb-tg" {
  name = "web-alb-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.web-site-vpc.id

  health_check {
    interval = 30
    path = "/wp-includes/images/blank.gif"
    port = 80
    protocol = "HTTP"
  }
}

# ターゲットインスタンス 1a
resource "aws_lb_target_group_attachment" "web-alb-tg-attachment-a" {
  target_group_arn = aws_lb_target_group.web-alb-tg.arn
  target_id = aws_instance.web-ec2-1a.id
  port = 80
}
# ターゲットインスタンス 1c
resource "aws_lb_target_group_attachment" "web-alb-tg-attachment-c" {
  target_group_arn = aws_lb_target_group.web-alb-tg.arn
  target_id = aws_instance.web-ec2-1c.id
  port = 80
}
