/*
# Resource 11 to create s3 bucket
resource "aws_s3_bucket" "project-1-bucket"{
  bucket = "backup-project-1-bucket"

  tags = {
    Name = "S3Bucket"
  }
}
*/