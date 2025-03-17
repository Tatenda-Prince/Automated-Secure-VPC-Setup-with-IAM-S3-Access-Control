resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = aws_vpc.secure_vpc.id  # Use secure_vpc instead of main
  service_name = "com.amazonaws.us-east-1.s3"
  
  vpc_endpoint_type = "Gateway"

  route_table_ids = [aws_route_table.private_rt.id]  # Attach to private route table

  tags = {
    Name = "S3VPC-Endpoint"
  }
}

