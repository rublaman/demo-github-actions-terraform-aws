provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-3"
}

variable "environment" {
  description = "Environment (develop, pre, pro)"
  type        = string
}

variable "ingest_bucket_name" {
  description = "Unique bucket name s3 ingest"
  type        = string
}

variable "processed_bucket_name" {
description = "Unique bucket name s3 processed"
  type        = string
}

module "s3_ingest" {
  source       = "../modules/s3"
  bucket_name  = var.ingest_bucket_name
  environment  = var.environment
}

module "s3_processed" {
  source       = "../modules/s3"
  bucket_name  = var.processed_bucket_name
  environment  = var.environment
}
