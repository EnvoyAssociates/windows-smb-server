terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    awsutils = {
      source  = "cloudposse/awsutils"
      version = ">= 0.11.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }

  required_version = ">= 1.5.4"
  backend "s3" {}
}

  default_tags {
    tags = {
      "Deployed By"  = "GitHub Actions"
      "Repo"         = "windows-smb-server"
      "Terraform"    = "true"
    }
  }