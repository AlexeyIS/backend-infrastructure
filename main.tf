locals {
  cluster_name  = "${var.name}-cluster-${var.env}"
  database_name = "${var.name}-docdb-cluster-${var.env}"
}

module "network" {
  source = "./modules/network"
  name   = "${var.name}-${var.env}"

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
  name       = "${var.name}-${var.env}"

  cluster_name           = local.cluster_name
  nodegroup_min_size     = 1
  nodegroup_desired_size = 1
  subnet_ids             = module.network.private_subnets_ids

  root_disk_size     = 20
  node_instance_type = "t3.small"

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


resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-${var.env}-db_subnet_group"
  subnet_ids = module.network.private_subnets_ids
  tags = {
    Terraform   = "true"
    Environment = var.env
  }
}

resource "aws_docdb_cluster_instance" "this" {
  count              = 1
  identifier         = "${var.name}-docdb-cluster-${var.env}-${count.index}"
  cluster_identifier = "${var.name}-docdb-cluster-${var.env}"
  instance_class     = var.db_instance_class
  depends_on         = [aws_docdb_cluster.this]
}

resource "aws_docdb_cluster" "this" {
  cluster_identifier      = "${var.name}-docdb-cluster-${var.env}"
  engine                  = "docdb"
  master_username         = var.db_master_username
  master_password         = var.db_master_password
  preferred_backup_window = var.preferred_backup_window
  db_subnet_group_name    = "${var.name}-${var.env}-db_subnet_group"
  skip_final_snapshot     = true
  depends_on              = [aws_db_subnet_group.this]
}

resource "aws_ecr_repository" "this" {
  count                = length(var.ecr_repositories_names)
  name                 = var.ecr_repositories_names[count.index]
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

