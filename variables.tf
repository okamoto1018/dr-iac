variable "admin_cidr" {
  description = "CIDR allowed to SSH to the bastion server"
  type        = string
}

variable "db_username" {
  description = "Master username for PostgreSQL"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Master password for PostgreSQL"
  type        = string
  sensitive   = true
}