# ターゲットグループの作成
resource "aws_lb_target_group" "web-alb-tg" {
  name     = "web-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.web-site-vpc.id

  health_check {
    interval = 30
    path     = "/wp-includes/images/blank.gif"
    port     = 80
    protocol = "HTTP"
  }
}

# ターゲットインスタンス 1a
resource "aws_lb_target_group_attachment" "web-alb-tg-attachment-a" {
  target_group_arn = aws_lb_target_group.web-alb-tg.arn
  target_id        = aws_instance.web-ec2-1a.id
  port             = 80
}
# ターゲットインスタンス 1c
resource "aws_lb_target_group_attachment" "web-alb-tg-attachment-c" {
  target_group_arn = aws_lb_target_group.web-alb-tg.arn
  target_id        = aws_instance.web-ec2-1c.id
  port             = 80
}
# ALB 本体
resource "aws_lb" "web-alb" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web-alb-sg.id]
  subnets            = [aws_subnet.web-site-public_1a.id, aws_subnet.web-site-public_1c.id]
}

# リスナールール
resource "aws_lb_listener" "web-alb-listener" {
  load_balancer_arn = aws_lb.web-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-alb-tg.arn
  }

}
