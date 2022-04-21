################
# Provider AWS #
################
provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Student   = "Borys.Bilkevych"
      Terrafrom = "True"
    }
  }
}