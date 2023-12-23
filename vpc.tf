resource "aws_cloudformation_stack" "eks_network" {
  name = "eks-network-stack"

  template_url = "https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/amazon-eks-vpc-private-subnets.yaml"
}
