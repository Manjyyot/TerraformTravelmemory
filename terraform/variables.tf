variable "aws_region" {
  description = "AWS region where resources will be deployed."
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "The key name to use for the EC2 instance."
  type        = string
  default     = "newManjyyot"
}

variable "vpc_id" {
  description = "The VPC ID to launch resources in."
  type        = string
  default     = "vpc-03c56cda94b8d7229"
}

variable "subnet_id" {
  description = "The subnet ID where the EC2 instance will be launched."
  type        = string
  default     = "subnet-0edea208a0374a0bf"
}
