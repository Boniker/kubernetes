######################################
# Cluster data for creating the pods #
######################################
data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.network.outputs.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.network.outputs.cluster_id
}