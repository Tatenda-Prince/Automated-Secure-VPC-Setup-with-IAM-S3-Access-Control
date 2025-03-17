resource "aws_s3_bucket" "secure_bucket" {
  bucket = "secure-private-s3-bucket-tatenda"
  force_destroy = true

  tags = {
    Name = "SecureS3Bucket"
  }
}

# Enable Versioning for Data Protection
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.secure_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable Server-Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.secure_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

