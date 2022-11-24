# Terraform学習
## スケーラブルWebサイト <br>
下記サイトを参考にしています。<br>
https://catalog.us-east-1.prod.workshops.aws/workshops/47782ec0-8e8c-41e8-b873-9da91e822b36/ja-JP


### WordPress 環境構築
```
yum install httpd -y

systemctl start httpd

systemctl enable httpd

amazon-linux-extras install php7.2

yum install -y php

wget http://ja.wordpress.org/latest-ja.tar.gz

tar -xzvf latest-ja.tar.gz

cp -r wordpress/* /var/www/html

chown apache:apache /var/www/html/ -R

systemctl restart httpd.service
```
