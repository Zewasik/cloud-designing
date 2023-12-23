
variable "cluster_name" {
  description = "Value of the cluster name of the cluster"
  type        = string
  default     = "cloud-design-cluster"
}

variable "cluster_role_name" {
  description = "Value of the cluster role name of the cluster"
  type        = string
  default     = "eksClusterRole"
}

variable "cluster_addons" {
  description = "Value of the cluster addons of the cluster"
  type        = list(string)
  default = [
    "vpc-cni",
    "kube-proxy",
    # "coredns",
  ]
}

variable "cluster_role_policy" {
  description = "Policy for cluster role"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController",
  ]
}

variable "nodegroup_role_policy" {
  description = "Policy for nodegroup role"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  ]
}

variable "nodegroup_role_name" {
  description = "Value of the nodegroup role name of the cluster"
  type        = string
  default     = "eksNodeRole"
}

variable "region_code" {
  description = "Value of the app region"
  type        = string
  default     = "eu-central-1"
}
