terraform {
  required_version = "1.14.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = ">= 4.0.0, < 5.0.0"
      version = "4.67.0"
    }
  }
}
