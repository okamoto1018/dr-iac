# ============================================================
# Internal ALB
#
# 1. Private Subnet 1a / 1c にInternal ALBを作成
# 2. Web EC2をTarget Groupに登録
# 3. HTTP:80 のListenerからTarget Groupへ転送
#
# ※ 今回はTGW等のALBへのアクセス経路は構築対象外
# ============================================================


# ------------------------------------------------------------
# Application Load Balancer
# ------------------------------------------------------------

resource "aws_lb" "web" {
  name               = "sample-internal-alb"
  internal           = true
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = [
    aws_subnet.private_1a.id,
    aws_subnet.private_1c.id
  ]

  tags = {
    Name = "sample-internal-alb"
  }
}


# ------------------------------------------------------------
# Target Group
# ALBからWeb EC2のHTTP:80へ転送
# ------------------------------------------------------------

resource "aws_lb_target_group" "web" {
  name     = "sample-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }

  tags = {
    Name = "sample-web-tg"
  }
}


# ------------------------------------------------------------
# Target Group Attachment
# Web EC2 × 2 をTargetとして登録
# ------------------------------------------------------------

resource "aws_lb_target_group_attachment" "web_1a" {
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = aws_instance.web_1a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "web_1c" {
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = aws_instance.web_1c.id
  port             = 80
}


# ------------------------------------------------------------
# Listener
# HTTP:80 → Target Group
# ------------------------------------------------------------

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}