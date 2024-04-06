terraform {
  backend "s3" {
    bucket         = "dimasutomo-cicd-tf-eks"
    key            = "jenkins/terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}