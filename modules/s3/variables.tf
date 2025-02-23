variable "bucket_name" {
  description = "Unique name for the bucket S3"
  type        = string
}

variable "environment" {
  description = "Environment (develop, staging, production"
  type        = string
  default     = "develop"
}
