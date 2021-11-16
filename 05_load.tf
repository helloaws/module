# Application LoadBalancer Deploy
resource "aws_lb" "lee_lb" {
  name                   = "${var.name}-alb"
  internal               = false
  load_balancer_type     = var.load_type
  security_groups        = [aws_security_group.lee_websg.id]
  subnets                = [aws_subnet.lee_pub[0].id,aws_subnet.lee_pub[1].id]
  
  tags = {
    Name  = "${var.name}-alb"
  }
}

resource "aws_lb_target_group" "lee_lbtg" {
  name      = "${var.name}-lbtg"
  port      =  var.port_http
  protocol  =  var.protocol_http1
  vpc_id    =  aws_vpc.lee_vpc.id

  health_check {
    enabled               = true
    healthy_threshold     = 3
    interval              = 5
    matcher               = "200"
    path                  = "/health.html" 
    port                  = "traffic-port"
    protocol              = var.protocol_http1
    timeout               = 2
    unhealthy_threshold   = 2 
  }
}

resource "aws_lb_listener" "lee_lblist" {
  load_balancer_arn       = aws_lb.lee_lb.arn
  port                    = var.port_http
  protocol                = var.protocol_http1

  default_action {
    type                  = "forward"
    target_group_arn      = aws_lb_target_group.lee_lbtg.arn  
  }
}

resource "aws_lb_target_group_attachment" "lee_lbtg_att" {
  target_group_arn      = aws_lb_target_group.lee_lbtg.arn
  target_id             = aws_instance.lee_web.id
  port                  = var.port_http
}