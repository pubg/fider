
terraform {
  backend "s3" {
    bucket  = "gd-rdu-feedback-tfstate"
    key     = "feedback/terraform.tfstate"
    region  = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "db" {
  source                     = "terraform-aws-modules/rds-aurora/aws"
  version                    = "~> 2.0"
  name                       = "rdu-${var.environment}-fider"
  engine                     = "aurora-postgresql"
  engine_mode                = "serverless"
  engine_version             = "10.7"
  vpc_id                     = var.vpc_id
  subnets                    = var.env_subnet_ids
  replica_scale_enabled      = false
  replica_count              = 0
  allowed_security_groups    = var.node_sg_id
  instance_type              = "db.r4.large"
  storage_encrypted          = true
  apply_immediately          = true
  monitoring_interval        = 10

  scaling_configuration = {
    auto_pause               = var.auto_pause
    max_capacity             = var.max_scaling
    min_capacity             = var.min_scaling
    timeout_action           = "ForceApplyCapacityChange"
  }

  tags = {
    Environment = "live"
    Terraform   = "true"
  }
}
