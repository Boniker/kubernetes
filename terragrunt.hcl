locals {
  aws_region       = "your_aws_region"
  aws_account_id   = "your_aws_account_id"
  alias             = "alias/bbilkevych_kubernetes"
  kms_key_id = "arn:aws:kms:${local.aws_region}:${local.aws_account_id}:${local.alias}"
  terraform_remote_state_s3_bucket      = "bbilkevych-${local.aws_account_id}-kubernetes-hw-8-state"
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    kms_key_id     = local.kms_key_id
    bucket         = "bbilkevych-${local.aws_account_id}-kubernetes-hw-8-state"    
    s3_bucket_tags = {
      Terragrunt   = "true"
      Owner        = "Borys.Bilkevych"
    }
    
    key            = "${local.aws_region}/${path_relative_to_include()}/kubernetes.tfstate"
    dynamodb_table = "bbilkevych-kubernetes-${local.aws_account_id}-lock-state"
    region         = local.aws_region
    
    dynamodb_table_tags = {
      Terragrunt = "true"
      Owner      = "Borys.Bilkevych"
    }
  }
}

inputs = {
  aws_region      = local.aws_region
  aws_account_id  = local.aws_account_id
  alias           = local.alias
  kms_key_id      = local.kms_key_id

  terraform_remote_state_s3_bucket      = "bbilkevych-${local.aws_account_id}-kubernetes-hw-8-state"
  terraform_remote_state_dynamodb_table = "kubernetes-lock-state"
  terraform_remote_state_file_name      = "kubernetes.tfstate"

  default_provider_tags = {
    Student   = "Borys.Bilkevych"
    Terrafrom = "True"
  }
}