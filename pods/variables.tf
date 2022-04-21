variable "aws_account_id" {}
variable "kms_key_id" {}
variable "alias" {}
variable "terraform_remote_state_s3_bucket" {}
variable "terraform_remote_state_dynamodb_table" {}
variable "terraform_remote_state_file_name" {}
variable "default_provider_tags" { type = map(any) }

variable "tags" {
  type        = map(string)
  description = "Tags applied to the KMS key."
  default     = {}
}
variable "aws_region" {
  description = "Region for our EKS. This makes sure everything is in the same region."
  type        = string
  default     = "eu-central-1"
}
variable "availability_zones" {
  description = "VPC availability zones"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}
variable "target_cidr_block" {
  description = "Cidr for the target VPC that is created"
  type        = string
  default     = "10.0.0.0/18"
}