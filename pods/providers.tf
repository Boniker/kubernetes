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

#######################
# Provider Kubernetes #
# #######################
provider "kubernetes" {
  host                   = element(concat(data.aws_eks_cluster.cluster[*].endpoint, tolist([])), 0)
  cluster_ca_certificate = base64decode(element(concat(data.aws_eks_cluster.cluster[*].certificate_authority.0.data, tolist([])), 0))
  token                  = element(concat(data.aws_eks_cluster_auth.cluster[*].token, tolist([])), 0)
}
