resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = merge(
    var.vpc_tags,
    local.common_tags,
    {
      Name = local.common_name_prefix
    }
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.igw_tags,
    local.common_tags,
    {
      Name = local.common_name_prefix
    }
  )
}

resource "aws_subnet" "public" {
  count = length(var.pub_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.az.names[count.index]
  map_public_ip_on_launch = true
  cidr_block = var.pub_subnet_cidrs[count.index]

  tags = merge(
    var.public_subnet_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-public-${local.az_names[count.index]}"
    }
  )
}


resource "aws_subnet" "private" {
  count = length(var.priv_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.az.names[count.index]
  cidr_block = var.priv_subnet_cidrs[count.index]

  tags = merge(
    var.private_subnet_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-private-${local.az_names[count.index]}"
    }
  )
}

resource "aws_subnet" "database" {
  count = length(var.db_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.az.names[count.index]
  cidr_block = var.db_subnet_cidrs[count.index]

  tags = merge(
    var.database_subnet_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-database-${local.az_names[count.index]}"
    }
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    var.public_route_table_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-public"
    }
  )
  
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = merge(
    var.private_route_table_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-private"
    }
  )
}

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = merge(
    var.database_route_table_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-database"
    }
  )
}

resource "aws_route_table_association" "public" {
  count = length(var.pub_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}  

resource "aws_route_table_association" "private" {
  count = length(var.priv_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "database" {
  count = length(var.db_subnet_cidrs)
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database.id
}

resource "aws_eip" "eip" {
  domain   = "vpc"

  tags = merge(
    var.eip_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}"
    }
  )
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.nat_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}"
    }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}



