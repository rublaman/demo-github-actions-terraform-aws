variable "environment" {
  description = "Entorno de despliegue (dev, stg, pro)"
  type        = string
  
  validation {
    condition     = contains(["dev", "stg", "pro"], var.environment)
    error_message = "El valor de environment debe ser uno de: dev, stg, o pro."
  }
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "rublaman"
}

variable "bucket_landing_name" {
  description = "Nombre del bucket S3 para datos de landing"
  type        = string
}

variable "bucket_raw_name" {
  description = "Nombre del bucket S3 para datos raw"
  type        = string
}

variable "bucket_curated_name" {
  description = "Nombre del bucket S3 para datos curated"
  type        = string
}

variable "bucket_ready_name" {
  description = "Nombre del bucket S3 para datos ready"
  type        = string
}