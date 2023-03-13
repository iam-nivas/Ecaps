service mariadb start
sleep 3
echo I have started mariadb
expect /home/mysql_secure_installation.sh
echo '[mysqld]' >> /etc/mysql/my.cnf 
echo 'character-set-client-handshake = FALSE' >> /etc/mysql/my.cnf 
echo 'character-set-server = utf8mb4' >> /etc/mysql/my.cnf 
echo 'collation-server = utf8mb4_unicode_ci' >> /etc/mysql/my.cnf 
echo '[mysql]' >> /etc/mysql/my.cnf 
echo 'default-character-set = utf8mb4' >> /etc/mysql/my.cnf
service mariadb restart
su - frappe <<EOF
cd /home/frappe/frappe-bench && bench new-site site1.local --mariadb-root-password root --admin-password root
echo 'site1.local' > /home/frappe/frappe-bench/sites/currentsite.txt
cd /home/frappe/frappe-bench && bench start 
EOF

bash