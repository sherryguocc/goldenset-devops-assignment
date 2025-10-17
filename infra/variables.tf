###############################################################
# Variables for reusability and flexibility
###############################################################

# AWS region
variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "ap-southeast-2" # Sydney
}

# EC2 instance type
variable "instance_type" {
  description = "The instance type for EC2"
  type        = string
  default     = "t2.micro"
}

# Key pair name for SSH access
variable "key_name" {
  description = "The name of an existing EC2 key pair for SSH access"
  type        = string
  default     = "sherry-keypair"
}


# AMI for Amazon Linux 2
variable "ami_id" {
  description = "Amazon Linux 2 AMI ID"
  type        = string
  default     = "ami-075924b436aa32cd4"
}

# Name prefix for tagging
variable "project_name" {
  description = "Name tag prefix for project resources"
  type        = string
  default     = "goldenset-devops-internship-assignment"
}
