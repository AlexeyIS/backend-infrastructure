##########
# Global
##########
variable "domain_apex" {
  description = "The domain apex"
  type        = string
  default     = "behyve.net"
}

variable "name" {
  description = "The name of the project"
  type        = string
  default     = "freelance"
}

variable "env" {
  description = "The name of the environment"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "The AWS region where all resources will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS Local profile defined at ~/.aws/credentials"
  type        = string
  default     = null
}

##########
# VPC
##########

variable "vpc_azs" {
  description = "A list of availability zones within the $aws_region for the VPC"
  type        = list(any)
  default     = []
}

variable "vpc_cidr" {
  description = "The CIDR address for the VPC"
  type        = string
}

variable "vpc_public_subents" {
  description = "The CIDR addresses for public subnets"
  type        = list(any)
  default     = []
}

variable "vpc_private_subents" {
  description = "The CIDR addresses for private subnets"
  type        = list(any)
  default     = []
}

##############
# ECR
##############

variable "ecr_repositories_names" {
  description = "The names of the ECR respositories"
  type        = list(any)
}

##############
# Database
##############
variable "db_master_username" {
  description = "The database username of the RDS PostgresSQL cluster"
  type        = string
}

variable "db_master_password" {
  description = "The database username of the the RDS PostgresSQL cluster"
  type        = string
}

variable "preferred_backup_window" {
  description = "The preferred timeframe to perfom the backup of the cluster on a daily basis"
  type        = string
}

variable "db_instance_class" {
  description = "DocumentDB instance class"
  type        = string
}





