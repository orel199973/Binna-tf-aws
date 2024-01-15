terraform {
  backend "s3" {
    bucket  = "s3-binna-tfstates"
    key     = "web-dev.tfstate"
    region  = "il-central-1"
    encrypt = true
  }
}