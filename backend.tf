terraform {
  backend "s3" {
    bucket = "magento-s3-tf"
    key    = "magento/terraform.tfstate"
    region = "ap-south-1"
  }
}
