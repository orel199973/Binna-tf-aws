terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  region = "il-central-1"
  alias  = "default"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}