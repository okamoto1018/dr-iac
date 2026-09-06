# ========================================
# Bastion Security Group
# ========================================

resource "aws_security_group" "bastion" {
  name        = "sample-bastion-sg"
  description = "Security group for bastion server"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "sample-bastion-sg"
  }
}

# 自分のPC → Bastion：SSH
resource "aws_vpc_security_group_ingress_rule" "bastion_ssh" {
  security_group_id = aws_security_group.bastion.id

  cidr_ipv4   = var.admin_cidr
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}

# Bastion → 外部：すべて許可
resource "aws_vpc_security_group_egress_rule" "bastion_all" {
  security_group_id = aws_security_group.bastion.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}


# ========================================
# ALB Security Group
# ========================================

resource "aws_security_group" "alb" {
  name        = "sample-alb-sg"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "sample-alb-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "alb_all" {
  security_group_id = aws_security_group.alb.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}


# ========================================
# Web Security Group
# ========================================

resource "aws_security_group" "web" {
  name        = "sample-web-sg"
  description = "Security group for web server"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "sample-web-sg"
  }
}

# ALB → Web：HTTP
resource "aws_vpc_security_group_ingress_rule" "web_http" {
  security_group_id = aws_security_group.web.id

  referenced_security_group_id = aws_security_group.alb.id

  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}

# Bastion → Web：SSH
resource "aws_vpc_security_group_ingress_rule" "web_ssh" {
  security_group_id = aws_security_group.web.id

  referenced_security_group_id = aws_security_group.bastion.id

  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "web_all" {
  security_group_id = aws_security_group.web.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}


# ========================================
# DB Security Group
# ========================================

resource "aws_security_group" "db" {
  name        = "sample-db-sg"
  description = "Security group for database"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "sample-db-sg"
  }
}

# Web → DB：PostgreSQL
resource "aws_vpc_security_group_ingress_rule" "db_postgresql" {
  security_group_id = aws_security_group.db.id

  referenced_security_group_id = aws_security_group.web.id

  from_port   = 5432
  to_port     = 5432
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "db_all" {
  security_group_id = aws_security_group.db.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}