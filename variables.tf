variable "vpc_cidr" {
  type = string
  #default = "10.0.0.0/16"
}

variable "instance_tenancy" {
  default = "default"
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "pub_subnet_cidrs" {
  type = list
}

variable "priv_subnet_cidrs" {
  type = list
}

variable "db_subnet_cidrs" {
  type = list
}

variable "vpc_tags" {
  type = map
  default = {}
}

variable "igw_tags" {
  type = map
  default = {}
}

variable "public_subnet_tags" {
  type = map
  default = {}
}

variable "private_subnet_tags" {
  type = map
  default = {}
}

variable "database_subnet_tags" {
  type = map
  default = {}
}

variable "public_route_table_tags" {
    type = map
    default = {}
}

variable "private_route_table_tags" {
    type = map
    default = {}
}

variable "database_route_table_tags" {
    type = map
    default = {}
}

variable "eip_tags" {
  type = map
  default = {}
}

variable "nat_tags" {
  type = map
  default = {}
}

variable "is_vpc_peering_required" {
  type = bool
  default = true
}