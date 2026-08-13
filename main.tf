resource "aws_vpc" "dr" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "sample-vpc"
  }
}