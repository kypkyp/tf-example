terraform {
  backend "s3" {
    bucket       = "terraform-up-and-running-state-kyp"
    key          = "stage/data-stores/mysql/terraform.tfstate"
    region       = "ap-northeast-1"
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

module "mysql" {
  source = "../../../modules/mysql"

  db_username = var.db_username
  db_password = var.db_password
}
