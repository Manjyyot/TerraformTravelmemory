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
variable "ami_id" {
  description = "The AMI ID for the instances"
  type        = string
  default     = "ami-04b4f1a9cf54c11d0"
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
  default     = "t2.micro"
}

variable "security_group_id" {
  description = "Existing security group ID"
  type        = string
  default     = "sg-0f9cc3bcfb3acb772"
}
