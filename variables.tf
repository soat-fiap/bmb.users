variable "profile" {
  description = "AWS profile name"
  type        = string
  default     = "default"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "user_pool_name" {
  type        = string
  description = "Cognito user pool name"
  default     = "bmb-users-pool-local"
}
