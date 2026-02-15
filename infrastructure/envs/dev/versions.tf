terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "wordpress-terraform-state-1771122707"
    key            = "dev/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "wordpress-tf-locks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}
