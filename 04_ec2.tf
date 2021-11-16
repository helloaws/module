resource "aws_security_group" "lee_websg" {
  name        = "Allow-WEB"
  description = "http-ssh-icmp"
  vpc_id      = aws_vpc.lee_vpc.id

  ingress = [
    {
      description       = var.protocol_ssh
      from_port         = var.port_ssh
      to_port           = var.port_ssh
      protocol          = var.protocol_tcp
      cidr_blocks       = [var.cidr]
      ipv6_cidr_blocks  = [var.cidr_v6]
      security_groups   =  null
      prefix_list_ids   =  null
      self              =  null
    },
    {
      description     = var.protocol_http
      from_port       = var.port_http
      to_port         = var.port_http
      protocol        = var.protocol_tcp
      cidr_blocks      = [var.cidr]
      ipv6_cidr_blocks  = [var.cidr_v6]
      security_groups  =  null
      prefix_list_ids  =  null
      self             =  null
    },
    {
      description       = var.protocol_icmp
      from_port         = var.port_minus
      to_port           = var.port_minus
      protocol          = var.protocol_icmp
      cidr_blocks       = [var.cidr]
      ipv6_cidr_blocks  = [var.cidr_v6]
      security_groups  =  null
      prefix_list_ids  =  null
      self             =  null
    },
    {
      description     = var.db_name
      from_port       = var.port_mysql
      to_port         = var.port_mysql
      protocol        = var.protocol_tcp
      cidr_blocks      = [var.cidr]
      ipv6_cidr_blocks  = [var.cidr_v6]
      security_groups  =  null
      prefix_list_ids  =  null
      self             =  null
    }
  ]

   egress = [
     {
      description     = "All"
      from_port        = var.port_zero
      to_port          = var.port_zero
      protocol         = var.protocol_minus
      cidr_blocks      = [var.cidr]
      ipv6_cidr_blocks = [var.cidr_v6]
      security_groups  =  null
      prefix_list_ids  =  null
      self             =  null
    }
   ]
  tags = {
    Name = "${var.name}-sg"
  }
} 


data "aws_ami" "amzn" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "lee_web" {
  ami                    = data.aws_ami.amzn.id                 #"ami-0e4a9ad2eb120e054"
  instance_type          = var.intance
  key_name               = var.key
  vpc_security_group_ids = [aws_security_group.lee_websg.id]
  availability_zone      = "${var.region}${var.avazone[0]}"
 # private_ip             = var.private_ip
  subnet_id              = aws_subnet.lee_pub[0].id
  user_data              = file("./intall.sh") 

  tags = {
    Name = "${var.name}-web"
  }
}
resource "aws_eip" "lee_web_eip" {
  vpc = true
  instance                    = aws_instance.lee_web.id
 # associate_with_private_ip   = var.private_ip
  depends_on                  = [aws_internet_gateway.lee_ig]
}