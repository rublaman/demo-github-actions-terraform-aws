variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Environment (develop, staging, production)"
  type        = string
}

variable "ingest_bucket_name" {
  description = "Unique bucket name s3 origin"
  type        = string
}

variable "processed_bucket_name" {
  description = "Unique bucket name s3 destination"
  type        = string
}
