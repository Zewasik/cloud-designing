locals {
  eks_network_subnets = split(",", aws_cloudformation_stack.eks_network.outputs["SubnetIds"])
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region_code
}

# provider "kubernetes" {
#   host                   = aws_eks_cluster.eks_cluster.endpoint
#   cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.cluster_auth.token
# }

# resource "kubernetes_config_map" "aws_auth" {
#   metadata {
#     name      = "aws-auth"
#     namespace = "kube-system"
#   }
#   data = {
#     "mapUsers" = "- userarn: arn:aws:iam::926127087481:user/Zewas\n      groups:\n      - system:masters"
#   }

#   depends_on = [aws_eks_node_group.eks_nodegroup]
# }
