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
# Backend
##############

# variable "instance_type" {
#   description = "The EC2 instance type of the backend server"
#   type        = string
#   default     = "t3.medium"
# }


##############
# Frontend
##############

# variable "frontend_domain" {
#   description = "The domain name of the bucket for the website"
#   type        = string
# }


# ##Database
# variable "postgres_node_type" {
#   description = "Postgres nodes instance type"
#   type        = string
#   default     = "db.t3.medium"
# }

# variable "db_master_username" {
#   description = "The database username of the RDS PostgresSQL cluster"
#   type        = string
# }

# variable "db_master_password" {
#   description = "The database username of the the RDS PostgresSQL cluster"
#   type        = string
# }

# variable "db_port" {
#   description = "The database port for the RDS PostgresSQL cluster"
#   type        = string
#   default     = "5432"
# }


