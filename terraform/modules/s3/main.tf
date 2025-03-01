# Módulo para crear y configurar buckets S3 para el proyecto

# Bucket de Landing
resource "aws_s3_bucket" "landing_bucket" {
  bucket = var.bucket_landing_name

  tags = {
    Name        = var.bucket_landing_name
    Environment = var.environment
    Project     = var.project_name
    Type        = "landing"
  }
}

# Bucket de Raw
resource "aws_s3_bucket" "raw_bucket" {
  bucket = var.bucket_raw_name

  tags = {
    Name        = var.bucket_raw_name
    Environment = var.environment
    Project     = var.project_name
    Type        = "raw"
  }
}

# Bucket de Curated
resource "aws_s3_bucket" "curated_bucket" {
  bucket = var.bucket_curated_name

  tags = {
    Name        = var.bucket_curated_name
    Environment = var.environment
    Project     = var.project_name
    Type        = "curated"
  }
}

# Bucket de Ready
resource "aws_s3_bucket" "ready_bucket" {
  bucket = var.bucket_ready_name

  tags = {
    Name        = var.bucket_ready_name
    Environment = var.environment
    Project     = var.project_name
    Type        = "ready"
  }
}

# Configuración de versionado para cada bucket
resource "aws_s3_bucket_versioning" "landing_bucket_versioning" {
  bucket = aws_s3_bucket.landing_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "raw_bucket_versioning" {
  bucket = aws_s3_bucket.raw_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "curated_bucket_versioning" {
  bucket = aws_s3_bucket.curated_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "ready_bucket_versioning" {
  bucket = aws_s3_bucket.ready_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Configuración de acceso público para cada bucket
resource "aws_s3_bucket_public_access_block" "landing_bucket_access" {
  bucket = aws_s3_bucket.landing_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "raw_bucket_access" {
  bucket = aws_s3_bucket.raw_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "curated_bucket_access" {
  bucket = aws_s3_bucket.curated_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "ready_bucket_access" {
  bucket = aws_s3_bucket.ready_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}