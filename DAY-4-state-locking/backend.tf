terraform {
  backend "s3" {
    bucket = "mybuckets3demo00"
    key    = "DAY-4/terraform.tfstate"
    region = "ap-south-1"
    profile = "TESTING"
    #use_lockfile = true #S3 supports the feature 
    dynamodb_table = "Test"
    encrypt = true
  }
}
