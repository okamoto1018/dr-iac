# ============================================================
# EC2
#
# 1. Amazon Linux 2023 の最新AMI情報を取得
# 2. 取得したAMIを使用してEC2インスタンスを作成
#    - Bastion：Public Subnet
#    - Web     ：Private Subnet
# ============================================================


# ------------------------------------------------------------
# AMI
# Amazon公式のAmazon Linux 2023から最新のAMIを取得
# ------------------------------------------------------------

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# ------------------------------------------------------------
# Bastion EC2
# 取得したAmazon Linux 2023のAMIを使用して作成
# ------------------------------------------------------------

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  subnet_id = aws_subnet.public_1a.id

  vpc_security_group_ids = [
    aws_security_group.bastion.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "sample-bastion"
  }
}


# ------------------------------------------------------------
# Web EC2 - 1a
# 取得したAmazon Linux 2023のAMIを使用して作成
# ------------------------------------------------------------

resource "aws_instance" "web_1a" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  subnet_id = aws_subnet.private_1a.id

  vpc_security_group_ids = [
    aws_security_group.web.id
  ]

  tags = {
    Name = "sample-web-1a"
  }
}


# ------------------------------------------------------------
# Web EC2 - 1c
# 取得したAmazon Linux 2023のAMIを使用して作成
# ------------------------------------------------------------

resource "aws_instance" "web_1c" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  subnet_id = aws_subnet.private_1c.id

  vpc_security_group_ids = [
    aws_security_group.web.id
  ]

  tags = {
    Name = "sample-web-1c"
  }
}