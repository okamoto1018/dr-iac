# Public Subnet
resource "aws_subnet" "public_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "public-subnet-1a"
  }
}

# Private Subnet 1a
resource "aws_subnet" "private_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.1.11.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "private-subnet-1a"
  }
}

# Private Subnet 1c
resource "aws_subnet" "private_1c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.1.12.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "private-subnet-1c"
  }
}

# Private Subnet 1d
resource "aws_subnet" "private_1d" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.1.13.0/24"
  availability_zone = "ap-northeast-1d"

  tags = {
    Name = "private-subnet-1d"
  }
}
