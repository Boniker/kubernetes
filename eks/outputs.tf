# VPC
output "vpc_target" {
  value       = module.vpc_target.vpc_id
  description = "VPC Target"
}

# Cidrs
output "vpc_target_cidr_block_target" {
  value       = var.target_cidr_block
  description = "VPC Target"
}

#Subnets
output "subnets_private" {
  value       = module.subnets.private_subnet_ids
  description = "Subnets"
}

output "subnets_public" {
  value       = module.subnets.public_subnet_ids
  description = "Subnets"
}

# Cluster #
output "cluster_arn" {
  value       = module.eks.cluster_arn
  description = "cluster_arn"
}
output "cluster_iam_role_arn" {
  value       = module.eks.cluster_iam_role_arn
  description = "cluster_iam_role_arn"
}

output "cluster_iam_role_name" {
  value       = module.eks.cluster_iam_role_name
  description = "cluster_iam_role_name"
}
output "cluster_id" {
  value       = module.eks.cluster_id
  description = "cluster_id"
}