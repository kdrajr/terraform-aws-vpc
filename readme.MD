# Terraform AWS VPC

This module creates the following resources

* VPC
* IGW
* 2 Public subnets in us-east-1a and us-east-1b AZ
* 2 Private subnets in us-east-1a and us-east-1b AZ
* 2 Database subnets in us-east-1a and us-east-1b AZ
* Public Route table
* Private Route table
* Database Route table
* EIP for NAT
* NAT Gateway in public subnet 1a az
* IGW route is added to public route table
* NAT gateway route to private and database route tables
* Route table association with subnets
* VPC to default VPC peering
* Public route table to default VPC route
* Default VPC main route table to created VPC route


### Inputs

* vpc_cidr - (Required). User must supply the CIDR for VPC.
* project - (Required). User must supply the project name.
* environment - (Required). User must supply the environment.
* pub_subnet_cidrs - (Required). User must supply the public subnet cidrs.
* priv_subnet_cidrs - (Required). User must supply the private subnet cidrs.
* db_subnet_cidrs - (Required). User must supply the database subnet cidrs.
* vpc_tags - (Optional). User can supply the tags for VPC.
* igw_tags - (Optional). User can supply the tags for internet gateway(igw).
* public_subnet_tags - (Optional). User can supply the tags for public subnet(s).
* private_subnet_tags - (Optional). User can supply the tags for private subnet(s).
* databse_subnet_tags - (Optional). User can supply the tags for database subnet(s).
* public_route_table_tags - (Optional). User can supply the tags for public route table.
* private_route_table_tags - (Optional). User can supply the tags for private route table.
* database_route_table_tags - (Optional). User can supply the tags for database route table.
* eip_tags - (Optional). User can supply the tags for elastic ip(eip).
* nat_tags - (Optional). User can supply the tags for NAT gateway.
* is_vpc_peering_required - (Optional). dafault to true.


### Outputs

* vpc_id - VPC ID of the VPC created.
* public_subent_ids - Public subnet ids of the VPC created.
* private_subent_ids - Private subnet ids of the VPC created.
* database_subent_ids - Database subnet ids of the VPC created.
