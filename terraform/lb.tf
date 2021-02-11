


resource "aws_lb" "earnix-lb" {
  name               = "earnix-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_vpc.vpc-earnix.default_security_group_id]
  subnets            = [aws_subnet.earnix-subnet-a.id , aws_subnet.earnix-subnet-b.id]


  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "front_end-httpd" {
  load_balancer_arn = aws_lb.earnix-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.earnix-tg-httpd.arn
  }
}

resource "aws_lb_listener" "front_end-lambda" {
  load_balancer_arn = aws_lb.earnix-lb.arn
  port              = "5000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.earnix-tg-lambda.arn
  }
}


output "lb-url" {
  value = aws_lb.earnix-lb.dns_name
}
