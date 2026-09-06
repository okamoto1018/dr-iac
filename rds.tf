# ============================================================
# RDS PostgreSQL
#
# 1. Private Subnet 1a / 1c からDB Subnet Groupを作成
# 2. PostgreSQLのRDSインスタンスを作成
# 3. 作成済みのDB用Security Groupを設定
#
# ※ 学習環境のためMulti-AZは使用しない
# ※ インターネットからRDSへ直接アクセスさせない
# ============================================================


# ------------------------------------------------------------
# DB Subnet Group
# RDSを配置するPrivate Subnetを指定
# ------------------------------------------------------------

resource "aws_db_subnet_group" "main" {
  name = "sample-db-subnet-group"

  subnet_ids = [
    aws_subnet.private_1a.id,
    aws_subnet.private_1c.id
  ]

  tags = {
    Name = "sample-db-subnet-group"
  }
}


# ------------------------------------------------------------
# RDS PostgreSQL
# ------------------------------------------------------------

resource "aws_db_instance" "postgres" {
  identifier = "sample-postgres"

  # Database
  engine         = "postgres"
  instance_class = "db.t3.micro"

  # Storage
  allocated_storage = 20
  storage_type      = "gp3"

  # Database account
  username = var.db_username
  password = var.db_password

  # Network
  db_subnet_group_name = aws_db_subnet_group.main.name

  vpc_security_group_ids = [
    aws_security_group.db.id
  ]

  publicly_accessible = false
  multi_az            = false

  # 学習環境のため削除時のSnapshotは作成しない
  skip_final_snapshot = true

  # 学習環境のため削除保護は無効
  deletion_protection = false

  tags = {
    Name = "sample-postgres"
  }
}