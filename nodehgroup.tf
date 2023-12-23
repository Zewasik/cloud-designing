resource "aws_iam_role" "eks_nodegroup_role" {
  name = var.nodegroup_role_name

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_nodegroup_policy_attachment" {
  count = length(var.nodegroup_role_policy)

  policy_arn = var.nodegroup_role_policy[count.index]
  role       = aws_iam_role.eks_nodegroup_role.name
}

resource "aws_eks_node_group" "eks_nodegroup" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "cloud-design-nodegroup"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = local.eks_network_subnets

  capacity_type = "ON_DEMAND"
  disk_size     = 10

  scaling_config {
    desired_size = 8
    max_size     = 8
    min_size     = 4
  }

  update_config {
    max_unavailable = 4
  }

  instance_types = ["t2.micro"]

  depends_on = [
    aws_iam_role_policy_attachment.eks_nodegroup_policy_attachment,
    aws_eks_cluster.eks_cluster
  ]
}
