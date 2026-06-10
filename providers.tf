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

provider "kubectl" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
  load_config_file       = false
}

