terraform {
  backend "s3" {
    bucket = "chinu.shop"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    profile = "TESTING"
  }
}
