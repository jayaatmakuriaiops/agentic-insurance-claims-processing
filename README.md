# Agentic Insurance Claims Processing - Terraform S3 Module

This Terraform module creates an S3 bucket with best practices configuration and integrates with Terraform Cloud for infrastructure provisioning.

## Prerequisites

- Terraform >= 1.0 installed
- AWS Account with appropriate permissions
- Terraform Cloud account
- Bitbucket account

## Project Structure

```
.
├── main.tf                    # Main Terraform configuration
├── variables.tf               # Input variables
├── outputs.tf                 # Output values
├── terraform.tfvars.example   # Example variable values
├── .terraformrc              # Terraform Cloud credentials
├── modules/
│   └── s3_bucket/
│       ├── main.tf           # S3 bucket module
│       ├── variables.tf      # Module variables
│       └── outputs.tf        # Module outputs
└── README.md                 # This file
```

## Setup Instructions

### 1. Configure Terraform Cloud

1. Sign up for [Terraform Cloud](https://app.terraform.io/)
2. Create a new organization
3. Generate an API token in User Settings > Tokens
4. Update the `.terraformrc` file with your API token:

```hcl
credentials "app.terraform.io" {
  token = "YOUR_TERRAFORM_CLOUD_API_TOKEN"
}
```

5. Update `main.tf` with your organization name:

```hcl
cloud {
  organization = "your-organization-name"
  workspaces {
    name = "s3-bucket-workspace"
  }
}
```

### 2. Configure AWS Credentials for Terraform Cloud

1. In Terraform Cloud, go to your workspace
2. Navigate to Settings > Variables
3. Add the following environment variables:
   - `AWS_ACCESS_KEY_ID`: Your AWS access key
   - `AWS_SECRET_ACCESS_KEY`: Your AWS secret key
   - Mark these as "Sensitive" and "Environment Variable"

### 3. Configure Local Variables

1. Copy the example variables file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

2. Edit `terraform.tfvars` with your values:

```hcl
aws_region          = "us-east-1"
bucket_name         = "my-unique-bucket-name-12345"
environment         = "dev"
project_name        = "insurance-claims"
versioning_enabled  = true
```

**Note**: The bucket name must be globally unique across all AWS accounts.

## Push to Bitbucket

### 1. Initialize Git Repository

```bash
git init
git add .
git commit -m "Initial commit: Terraform S3 module with Terraform Cloud integration"
```

### 2. Create Bitbucket Repository

1. Log in to [Bitbucket](https://bitbucket.org/)
2. Create a new repository
3. Copy the repository URL

### 3. Push to Bitbucket

```bash
git remote add origin https://bitbucket.org/YOUR_USERNAME/YOUR_REPO.git
git branch -M main
git push -u origin main
```

## Connect Bitbucket to Terraform Cloud

### 1. Connect Bitbucket in Terraform Cloud

1. In Terraform Cloud, go to your organization
2. Navigate to Settings > VCS Providers
3. Click "Connect a VCS Provider"
4. Select "Bitbucket" and follow the OAuth authorization flow

### 2. Create Workspace from Bitbucket

1. In Terraform Cloud, click "New Workspace"
2. Select "Version Control Workflow"
3. Choose your connected Bitbucket account
4. Select the repository you pushed
5. Configure the workspace:
   - Name: `s3-bucket-workspace`
   - Terraform Working Directory: `.` (root)
   - Terraform Version: `latest`
6. Click "Create Workspace"

### 3. Configure Workspace Variables

1. In the workspace, go to Settings > Variables
2. Add the following variables:
   - `aws_region`: Your AWS region
   - `bucket_name`: Your unique bucket name
   - `environment`: Environment name
   - `project_name`: Project name
   - `versioning_enabled`: `true` or `false`
3. Mark sensitive variables appropriately

## Run Terraform

### Via Terraform Cloud

1. In your Terraform Cloud workspace, click "Queue Plan"
2. Review the plan
3. Click "Confirm & Apply" to apply the changes

### Locally (for testing)

```bash
terraform init
terraform plan
terraform apply
```

## Module Features

The S3 bucket module includes:

- **Versioning**: Enabled by default for data protection
- **Server-side encryption**: AES256 encryption at rest
- **Public access block**: Blocks all public access for security
- **Lifecycle rules**: Auto-expiration of objects (default: 90 days)
- **Bucket ownership**: BucketOwnerEnforced for security
- **Tagging**: Automatic tagging with project, environment, and managed-by tags

## Outputs

After deployment, the following outputs are available:

- `s3_bucket_id`: The bucket ID
- `s3_bucket_arn`: The bucket ARN
- `s3_bucket_name`: The bucket name
- `s3_bucket_region`: The AWS region

## Security Considerations

- Never commit `.terraformrc` with real API tokens to version control
- Use environment variables for sensitive data in Terraform Cloud
- Ensure bucket names are globally unique
- Review AWS IAM permissions required for the module

## Cleanup

To destroy the infrastructure:

```bash
terraform destroy
```

Or via Terraform Cloud: Click "Destroy" in the workspace settings.

## Support

For issues or questions, please refer to:
- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Cloud Documentation](https://www.terraform.io/docs/cloud)
