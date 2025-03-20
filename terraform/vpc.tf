resource "aws_vpc" "keda_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.keda_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.keda_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.keda_vpc.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.keda_vpc.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "subnet_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "subnet_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.public.id
}
