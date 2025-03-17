output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.secure_vpc.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private_subnet.id
}

output "ec2_instance_id" {
  description = "ID of the private EC2 instance"
  value       = aws_instance.private_ec2.id
}

output "s3_bucket_name" {
  description = "Name of the secure S3 bucket"
  value       = aws_s3_bucket.secure_bucket.id
}
