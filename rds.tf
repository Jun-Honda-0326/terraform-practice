# # DB サブネットグループの作成
# resource "aws_db_subnet_group" "db-subnet" {
#   name        = "web-rds-db-subnet"
#   description = "Web-RDS-DB-Subnet"
#   subnet_ids = [
#     aws_subnet.web-site-private_1a.id,
#     aws_subnet.web-site-private_1c.id
#   ]
#   tags = {
#     Name = "web-rds-db-subnet"
#   }
# }

# # DBパラメータグループ
# resource "aws_db_parameter_group" "mysql-parameter-group" {
#   name   = "rds-pg"
#   family = "mysql8.0"

#   parameter {
#     name  = "character_set_server"
#     value = "utf8"
#   }

#   parameter {
#     name  = "character_set_client"
#     value = "utf8"
#   }
# }

# # オプショングループ
# resource "aws_db_option_group" "mysql_option_group" {
#   name                 = "mysql-option-group"
#   engine_name          = "mysql" //DBインスタンスに使用するエンジンを設定する。
#   major_engine_version = "8.0"   //エンジンのメジャーバージョンを設定する。
# }

# variable "rds_password" {}

# resource "aws_db_instance" "web-rds" {
#   allocated_storage           = 20                                                //ストレージ
#   db_name                     = "webrds"                                         //DB名
#   engine                      = "mysql"                                           //DBエンジン
#   engine_version              = "8.0"                                             //DBバージョン
#   instance_class              = "db.t2.micro"                                     //DB インスタンスクラス
#   storage_type                = "gp2"                                             //ストレージタイプ
#   allow_major_version_upgrade = false                                             //メジャーバージョンのアップデート有無
#   auto_minor_version_upgrade  = false                                             //マイナーバージョンのアップデート
#   apply_immediately           = true                                              // RDSの設定変更を即時反映するかどうか
#   username                    = "root"                                            // ユーザー名
#   password                    = var.rds_password                                  // パスワード
#   parameter_group_name        = aws_db_parameter_group.mysql-parameter-group.name //パラメータグループ
#   option_group_name           = aws_db_option_group.mysql_option_group.name
#   skip_final_snapshot         = true
#   identifier                  = "web-rds"                          //識別子
#   port                        = 3306                               // 開放ポート番号
#   vpc_security_group_ids      = [aws_security_group.web-rds-sg.id] // セキュリティグループ
#   db_subnet_group_name        = aws_db_subnet_group.db-subnet.name // DBサブネットグループ
#   publicly_accessible         = false                              // インターネットアクセス有効・非有効
# }
