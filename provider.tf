provider "aws" {
  shared_credentials_file = "%USERPROFILE%\\.aws\\credentials"
  region                  = var.aws_region
  profile                 = var.aws_profile
}