output "cluster_ca" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "cluster_name" {
  description = "cluster output name"
  value       = aws_eks_cluster.eks_cluster.name
}

output "region" {
  description = "AWS region"
  value       = var.region_code
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

# output "nodegroup_secutiry_group" {
#   value = aws_eks_node_group.eks_nodegroup.resources
#   #   [*]["remote_access_security_group_id"]
# }
