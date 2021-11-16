resource "aws_eip" "lb_ip" {
#  instance = aws_instance.web.id
  vpc      = true
}
resource "aws_nat_gateway" "lee_nga" {
  allocation_id = aws_eip.lb_ip.id
  subnet_id     = aws_subnet.lee_pub[0].id
  tags = {
    Name = "${var.name}-ng"
  }
}

resource "aws_route_table" "lee_ngart" {
  vpc_id  =  aws_vpc.lee_vpc.id
 
  route {
    cidr_block  = var.cidr
    gateway_id  = aws_nat_gateway.lee_nga.id
  }
  tags  = {
    Name  = "${var.name}-ng-rt"
  }
}

resource "aws_route_table_association" "lee_ngartas" {
  count          = "${length(var.avazone)}" 
  subnet_id      = aws_subnet.lee_pri[count.index].id
  route_table_id = aws_route_table.lee_ngart.id
}