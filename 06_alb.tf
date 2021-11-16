resource "aws_ami_from_instance" "lee_ami" {
  name                    = "${var.name}-ami"
  source_instance_id      = aws_instance.lee_web.id
  depends_on = [
    aws_instance.lee_web
  ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "lee_lacf" {
  name                 = "${var.name}-web"
  image_id             = aws_ami_from_instance.lee_ami.id
  instance_type        = var.intance
  iam_instance_profile = "admin-role"
  security_groups      = [aws_security_group.lee_websg.id]
  key_name             = var.key
  user_data            =<<-EOF
                        #!/bin/bash
                        systemctl start httpd
                        systemctl enable httpd
                        EOF
  lifecycle {
    create_before_destroy  = true
  }
}

resource "aws_placement_group" "lee_pg" {
  name     = "${var.name}-pg"
  strategy = var.strategy
}

resource "aws_autoscaling_group" "lee_atsg" {
  name                      = "${var.name}-atsg"
  min_size                  = 2
  max_size                  = 8
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.lee_lacf.name
  vpc_zone_identifier       = [aws_subnet.lee_pub[0].id,aws_subnet.lee_pub[1].id]
}

resource "aws_autoscaling_attachment" "lee_atatt" {
  autoscaling_group_name = aws_autoscaling_group.lee_atsg.id
  alb_target_group_arn   = aws_lb_target_group.lee_lbtg.arn
}