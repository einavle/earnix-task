


data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["amazon"]

}

resource "aws_launch_configuration" "as_conf" {
  name = "earnix-lc"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  spot_price    = "0.003500"
  user_data = file("install_software.sh")

  security_groups = [aws_vpc.vpc-earnix.default_security_group_id]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "earnix-tg" {
  name     = "earnix-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-earnix.id
  health_check {
    interval = 30
    path = "/app.html"
    protocol = "HTTP"
  }

}


resource "aws_autoscaling_group" "earnix-asg" {
  name                 = "earnix-asg"
  min_size             = 0
  max_size             = 3
  desired_capacity = 3
  vpc_zone_identifier = [aws_subnet.earnix-subnet-a.id, aws_subnet.earnix-subnet-b.id]
  launch_configuration = aws_launch_configuration.as_conf.name
  target_group_arns = [aws_lb_target_group.earnix-tg.arn]
}
