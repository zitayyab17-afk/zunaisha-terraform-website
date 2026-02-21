terraform {
  backend "s3" {
    bucket         = "project1-terraform-statfile"
    key            = "s3-cloudfront-project/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "project1-terraform-lock"
    encrypt        = true
  }
}