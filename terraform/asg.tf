


data "aws_ami" "amazon-linux-2" {
  most_recent = true


  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
  owners = ["amazon"]
}


resource "aws_launch_configuration" "as_conf" {
  name = "earnix-lc"
  image_id      = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"
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
    path = "/"
    protocol = "HTTP"
  }

}


resource "aws_autoscaling_group" "earnix-asg" {
  name                 = "earnix-asg"
  min_size             = 0
  max_size             = 2
  desired_capacity = 2
  vpc_zone_identifier = [aws_subnet.earnix-subnet-a.id, aws_subnet.earnix-subnet-b.id]
  launch_configuration = aws_launch_configuration.as_conf.name
  target_group_arns = [aws_lb_target_group.earnix-tg.arn]
}
