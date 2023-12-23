resource "aws_iam_role" "eks_cluster_role" {
  name = var.cluster_role_name

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "eks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_policy_attachment" {
  count = length(var.cluster_role_policy)

  policy_arn = var.cluster_role_policy[count.index]
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = local.eks_network_subnets
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  depends_on = [
    aws_iam_role_policy_attachment.eks_policy_attachment,
    aws_cloudformation_stack.eks_network,
    aws_cloudwatch_log_group.cloudwatch_group
  ]
}

resource "aws_eks_addon" "cluster_addons" {
  count = length(var.cluster_addons)

  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = var.cluster_addons[count.index]
}

resource "aws_eks_addon" "cluster_addon_dns" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "coredns"

  depends_on = [aws_eks_node_group.eks_nodegroup]
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.cluster_name
}
