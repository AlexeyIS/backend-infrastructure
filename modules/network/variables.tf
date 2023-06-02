##########
# Global
##########
variable "name" {
  description = "The name of the project"
  type        = string
}

# variable "domain_apex" {
#   description = "The domain apex"
#   type        = string
# }

variable "tags" {
  description = "The list of default tags to be added to resources within this module"
  type        = map(any)
  default     = {}
}


##########
# VPC
##########

variable "azs" {
  description = "List of Availabilty zones for the VPC"
  type        = list(string)
}

variable "vpc_cidr" {
  description = "The cidr block of the netowrk VPC"
  type        = string
}

#####################
# Public Subents
####################

variable "vpc_public_subents" {
  description = "List of CIDR ranges for public services subnets"
  type        = list(string)
}

variable "public_subnets_tags" {
  description = "List of tags for public subnets"
  type        = map(any)
}


#####################
# Private Subents
####################

variable "vpc_private_subents" {
  description = "List of CIDR ranges for private services subnets"
  type        = list(string)
}

variable "private_subnets_tags" {
  description = "List of tags for private subnets"
  type        = map(any)
}


