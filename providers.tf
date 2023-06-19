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
    bucket  = "<s3-bucket-name>"
    key     = "terraform.tfstate"
    profile = "<aws-profile>"
    region  = "<aws-region>"
  }
}

provider "aws" {
  # Configuration options
  region  = var.aws_region
  profile = var.aws_profile
}


