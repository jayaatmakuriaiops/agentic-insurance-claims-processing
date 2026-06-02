terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  cloud {
    organization = "your-organization-name"
    workspaces {
      name = "s3-bucket-workspace"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

module "s3_bucket" {
  source = "./modules/s3_bucket"

  bucket_name = var.bucket_name
  environment = var.environment
  project_name = var.project_name

  versioning_enabled = var.versioning_enabled
}
