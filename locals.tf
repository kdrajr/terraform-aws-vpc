locals {
    common_name_prefix = "${var.project}-${var.environment}"
    common_tags = {
        Project = var.project
        Environment = var.environment
        Terraform = true
    }
    sliced_list = slice(data.aws_availability_zones.az.names,0,2) 
    az_names = [for item in local.sliced_list : trimprefix(item, "us-east-")]
}