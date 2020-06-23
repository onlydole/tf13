variable "instance_type" {
  type        = string
  description = "Instance type to use"
  default     = "m5.large"
}

variable "cluster_name" {
  type        = string
  description = "Default name for an EC2 cluster"
  default     = "zero-thirteen"
}

variable "region" {
  type        = string
  description = "Default AWS Region to use"
  default     = "us-west-2"
}

# Step 4 - Custom Validation
# variable "ami_id" {
#   type = string

#   validation {
#     condition     = can(regex("^ami-", var.ami_id))
#     error_message = "Must be an AMI id, starting with \"ami-\"."
#   }
# }