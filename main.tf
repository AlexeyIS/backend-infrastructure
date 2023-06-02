locals {
  cluster_name = "${var.name}-cluster"
}

module "network" {
  source = "./modules/network"
  name   = var.name

  vpc_cidr = var.vpc_cidr
  azs      = var.vpc_azs

  vpc_public_subents = var.vpc_public_subents
  public_subnets_tags = {
    "kubernetes.io/role/elb"                      = "1"
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  vpc_private_subents  = var.vpc_private_subents
  private_subnets_tags = {}


  tags = {
    Terraform   = "true"
    Environment = var.env
  }
}

module "eks_cluster" {
  depends_on = [module.network]
  source     = "./modules/eks"
  name       = var.name

  cluster_name           = local.cluster_name
  nodegroup_min_size     = 1
  nodegroup_desired_size = 2
  subnet_ids             = module.network.private_subnets_ids

  root_disk_size     = 20
  node_instance_type = "t3.medium"

  tags = {
    Terraform   = "true"
    Environment = var.env
  }
}


module "charts" {
  source = "./modules/charts"

  aws_profile = var.aws_profile

  cluster_name     = module.eks_cluster.cluster_name
  cluster_endpoint = module.eks_cluster.endpoint
  cluster_ca_cert  = module.eks_cluster.certificate_authority_data
}