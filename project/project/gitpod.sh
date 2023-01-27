#!/bin/bash
pip install -q -r requirements.txt
pip -q install pymysql flask  flask_sqlalchemy flask_login PyPDF2==2.4.0 flask_mail


apt install mysql-server -y > /dev/null
echo -e "[mysql]\nuser = root\npassword = root" > ~/.my.cnf
service mysql start
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root'"
mysql -u root -e "CREATE DATABASE IF NOT EXISTS hms;"

mysql -u root < hms.sql 
python3 main.py