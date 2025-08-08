terraform {
  backend "s3" {
    bucket = "mybuckets3demo00"
    key = "DAY-4/terraform.tfstateclea"
    region = "ap-south-1"
    profile = "TESTING"
    
  }
}