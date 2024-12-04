terraform {
  backend "s3" {
    bucket         = "state-log-files-tf"
    key            = "terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
  }
}