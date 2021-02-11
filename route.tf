
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc-earnix.id

  tags = {
    Name = "earnix-igw"
  }
}

resource "aws_eip" "lb" {
  vpc      = true
}



resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.vpc-earnix.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public"
  }
}



resource "aws_route_table_association" "public-route-a" {
  subnet_id      = aws_subnet.earnix-subnet-a.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "public-route-b" {
  subnet_id      = aws_subnet.earnix-subnet-b.id
  route_table_id = aws_route_table.public-route.id
}
