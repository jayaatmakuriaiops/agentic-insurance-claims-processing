###############################################################
# AWS Provider Configuration
###############################################################


provider "aws" {
  region = var.region

  default_tags {
    tags = local.tags
  }
}

# Virginia provider for ECR Public access
provider "aws" {
  alias  = "virginia"
  region = "us-east-1"

  default_tags {
    tags = local.tags
  }
}

