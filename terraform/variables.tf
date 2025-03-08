variable "key_name" {
  description = "The key name to use for the EC2 instance."
  type        = string
  default     = "newManjyyot.pem"
}

variable "vpc_id" {
  description = "The VPC ID to launch resources in."
  default     = "vpc-03c56cda94b8d7229"
}

variable "subnet_id" {
  description = "The subnet ID where the EC2 instance will be launched."
  default     = "subnet-0edea208a0374a0bf"
}

