terraform {
  backend "s3" {
    bucket = "mybuckets3demo00"
    key =  "DAY-5-Cs/terraform.tfstate"
    region = "ap-south-1"
    use_lockfile = true 
    
  }
}