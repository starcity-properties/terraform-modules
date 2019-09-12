# ##############################################
# Application Load Balancer
# ##############################################

# ALB Instance
resource "aws_lb" "alb" {
  name               = "${var.application}-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = var.public_subnet_ids

  access_logs {
    bucket  = var.log_bucket
    prefix  = "access_logs/${var.application}"
    enabled = true
  }

  tags = {
    Name        = "${var.application}-alb-${var.environment}"
    Environment = var.environment
  }
}

# ALB Listener
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "alb-listener-https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-target-group.arn
  }
}

# Target Group
resource "aws_lb_target_group" "lb-target-group" {
  name        = "${var.application}-target-group-${var.environment}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  depends_on  = [aws_lb.alb]

  health_check {
    healthy_threshold   = lookup(var.alb_health_check, "healty_threshhold", 2)
    unhealthy_threshold = lookup(var.alb_health_check, "unhealty_threshhold", 2)
    timeout             = lookup(var.alb_health_check, "timeout", 5)
    path                = lookup(var.alb_health_check, "path", "/")
    interval            = lookup(var.alb_health_check, "interval", 10)
    matcher             = lookup(var.alb_health_check, "matcher", "200")
  }
}

# ALB Security Group
resource "aws_security_group" "alb-sg" {
  name        = "${var.application}-alb-sg-${var.environment}"
  vpc_id      = var.vpc_id
  description = "Security group that allows HTTP & HTTPS traffic to load balancer from anywhere"

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.application}-alb-sg-${var.environment}"
    Environment = var.environment
  }
}

