locals {
    common_name_prefix = "${var.project_name}-${var.environment}"
    common_tags = {
        Project = var.project_name
        Environment = var.environment
        Terraform = true
    }
    az_names = slice(data.aws_availability_zones.az.names,0,2) 
    #az_names = [for item in local.sliced_list : trimprefix(item, "us-east-")]
}