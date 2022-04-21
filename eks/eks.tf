###############
# EKS cluster #
###############
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.5.0"

  cluster_name    = local.name
  cluster_version = local.version

  cluster_endpoint_private_access = false
  cluster_endpoint_public_access  = true

  vpc_id     = module.vpc_target.vpc_id
  subnet_ids = module.subnets.public_subnet_ids

  cluster_enabled_log_types = ["api"]

  # Added the cluster add-ons #
  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  # It is also used to encrypt/decrypt sensitive data stored in Kubernetes secrets. #
  cluster_encryption_config = [{
    provider_key_arn = "${var.kms_key_id}"
    resources        = ["secrets"]
  }]

  # EKS Managed Node Group(s) Defaults. Template #
  eks_managed_node_group_defaults = {
    ami_type         = "AL2_x86_64"
    instance_types   = ["t2.medium", "t3.medium"]
    capacity_type    = "SPOT"
    desired_capacity = 1
    max_capacity     = 2
    min_capacity     = 1
  }

  # EKS Managed Node Group(s) #
  eks_managed_node_groups = {
    private_node_1 = {
      subnet_ids = [module.subnets.private_subnet_ids[0]]
      block_device_mappings = {
        root = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 8
            volume_type           = "gp3"
          }
        }
      }

      # Disable the metadata for ettin the access for curl command #
      metadata_options = {
        http_put_response_hop_limit = 2
        http_tokens                 = "optional"
        http_endpoint               = "enabled"
      }
    }
  }
}