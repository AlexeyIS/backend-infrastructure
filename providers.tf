terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0.1"
    }
  }

  ###Variables not allowed within here so all the following values needs to be hardcoded
  backend "s3" {
    bucket  = "test-state-12315j"
    key     = "terraform.tfstate"
    profile = "gdi"
    region  = "us-east-1"
  }
}

provider "aws" {
  # Configuration options
  region  = var.aws_region
  profile = var.aws_profile
}


