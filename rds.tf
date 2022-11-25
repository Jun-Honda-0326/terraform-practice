# DB サブネットグループの作成
resource "aws_db_subnet_group" "db-subnet" {
  name = "web-rds-db-subnet"
  description = "Web-RDS-DB-Subnet"
  subnet_ids = [
    aws_subnet.web-site-private_1a.id,
    aws_subnet.web-site-private_1c.id
  ]
  tags = {
    Name = "web-rds-db-subnet"
  }
}

# DBパラメータグループ
resource "aws_db_parameter_group" "mysql-parameter-group" {
  name = "rds-pg"
  family = "mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}
