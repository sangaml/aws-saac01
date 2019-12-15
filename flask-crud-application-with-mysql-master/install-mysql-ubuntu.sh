MYSQL_USER=root
MYSQL_PASSWORD=password
echo "mysql-community-server mysql-community-server/root-pass password $MYSQL_PASSWORD" | debconf-set-selections
echo "mysql-community-server mysql-community-server/re-root-pass password $MYSQL_PASSWORD" | debconf-set-selections

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 5072E1F5
if [ -f /etc/apt/sources.list.d/mysql.list ]; then
    echo -e "mysql repo already exists."
    echo -e "Removing old repo and creating new one."
    rm -f /etc/apt/sources.list.d/mysql.list
    echo "deb http://repo.mysql.com/apt/ubuntu/ trusty mysql-5.7" | tee /etc/apt/sources.list.d/mysql.list
else
    echo -e "Creating mysql repo."
    echo "deb http://repo.mysql.com/apt/ubuntu trusty mysql-5.7" | tee /etc/apt/sources.list.d/mysql.list
fi
apt-get update 
apt-get install mysql-server -y

mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -e "DELETE FROM mysql.user WHERE User='';"
mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -e "DROP DATABASE test;"
mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%'"
mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -e "FLUSH PRIVILEGES;"
