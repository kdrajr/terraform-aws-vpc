resource "aws_vpc_peering_connection" "roboshop_default" {
  count = var.is_vpc_peering_required ? 1 : 0
  peer_vpc_id   = data.aws_vpc.default.id
  vpc_id        = aws_vpc.main.id
  auto_accept   = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  
  tags = merge(
    var.vpc_tags,
    local.common_tags,
    {
        Name = "${local.common_name_prefix}-default"
    }
  )  
}

resource "aws_route" "roboshop-default" {
  count = var.is_vpc_peering_required ? 1 : 0
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.roboshop_default[count.index].id
}

resource "aws_route" "default-roboshop" {
  count = var.is_vpc_peering_required ? 1 : 0
  route_table_id            = data.aws_route_table.default_rt.id
  destination_cidr_block    = aws_vpc.main.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.roboshop_default[count.index].id
}