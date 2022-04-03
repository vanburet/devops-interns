terraform {
  backend "s3" {
    bucket  = "ls-terraform-states"
    key     = ""
    region  = "us-east-1"
    profile = "aws-ds-s3"
  }
}
