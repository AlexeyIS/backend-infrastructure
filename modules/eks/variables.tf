##########
# Global
##########
variable "name" {
  description = "The name of the project"
  type        = string
}

variable "tags" {
  description = "The list of default tags to be added to resources within this module"
  type        = map(any)
  default     = {}
}


variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}


variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "root_disk_size" {
  description = "The EBS root disk size of each Node"
  type        = string
}


variable "node_instance_type" {
  description = "The EC2 instance type of each Node"
  type        = string
}

variable "nodegroup_desired_size" {
  description = "Node groups desired size of nodes"
  type        = number
}

variable "nodegroup_min_size" {
  description = "Node groups minimum size of nodes"
  type        = number
}

