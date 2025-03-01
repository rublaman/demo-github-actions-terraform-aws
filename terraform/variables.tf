variable "aws_region" {
  description = "La región de AWS donde se desplegarán los recursos"
  type        = string
  default     = "eu-west-3" # Paris
}

variable "environment" {
  description = "El entorno en el que se desplegarán los recursos (dev, stg, pro)"
  type        = string
  validation {
    condition     = contains(["dev", "stg", "pro"], var.environment)
    error_message = "El valor de environment debe ser uno de: dev, stg, o pro."
  }
}

variable "terraform_state_bucket" {
  description = "El nombre del bucket S3 donde se almacenará el estado de Terraform"
  type        = string
}

variable "s3_bucket_landing" {
  description = "El nombre del bucket S3 para datos de aterrizaje (landing)"
  type        = string
}

variable "s3_bucket_raw" {
  description = "El nombre del bucket S3 para datos raw"
  type        = string
}

variable "s3_bucket_curated" {
  description = "El nombre del bucket S3 para datos curados (curated)"
  type        = string
}

variable "s3_bucket_ready" {
  description = "El nombre del bucket S3 para datos listos para su uso (ready)"
  type        = string
}