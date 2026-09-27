variable "aws_region" {
  description = "AWS region used for the project"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name used for project resources"
  type        = string
  default     = "aws-eks-cicd-pipeline"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "aws-eks-cicd-cluster"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}