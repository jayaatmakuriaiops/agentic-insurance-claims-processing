###############################################################
# Terraform Version Constraints
###############################################################

terraform {
  required_version = ">= 1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.95.0, < 6.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.12"
    }
  }

  cloud {
    organization = "jayaatmakuriaiops"
    workspaces {
      name = "agentic-insurance-claims-processing"
    }
  }
  #Optional: Configure remote state backend
  # backend "s3" {
  #   bucket         = "langgraph-insurance-terraform-state"
  #   key            = "infrastructure/terraform.tfstate"
  #   region         = "us-west-2"
  #   dynamodb_table = "langgraph-insurance-terraform-lock"
  #   encrypt        = true
  # }
}