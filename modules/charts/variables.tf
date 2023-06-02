variable "cluster_endpoint" {
  description = "The EKS cluster endpoint"
  type        = string
}

variable "cluster_ca_cert" {
  description = "The certificate authority certificate of the EKS cluster"
}

variable "cluster_name" {
  description = "The EKS cluster name"
  type        = string
}

variable "aws_profile" {
  description = "The aws enviornment locally configured porfile name"
  type        = string
}


