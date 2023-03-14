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
cd /home/frappe/ && bench init frappe-bench --frappe-branch dev-version-14 --frappe-path http://akash:asdqwe123@113.193.30.98/frappe/Frappe-V14.git
cd /home/frappe/frappe-bench && bench new-site site1.local --mariadb-root-password root --admin-password root
echo 'site1.local' > /home/frappe/frappe-bench/sites/currentsite.txt
cd /home/frappe/frappe-bench && bench get-app erpnext http://akash:asdqwe123@113.193.30.98/erpnext/Erpnext-V14.git --branch dev-version-14
cd /home/frappe/frappe-bench && bench get-app formulation http://akash:asdqwe123@113.193.30.98/ecapsule/eCapsule-V14.git
cd /home/frappe/frappe-bench && bench get-app lms http://akash:asdqwe123@113.193.30.98/lms/lms-V14.git --branch dev-version-14
cd /home/frappe/frappe-bench && bench get-app indian-compliance http://akash:asdqwe123@113.193.30.98/indian-compliance/indian-compliance-V14.git --branch dev-version-14
cd /home/frappe/frappe-bench && bench get-app hrms http://akash:asdqwe123@113.193.30.98/hrms/hrms-v14.git --branch dev-version-14
cd /home/frappe/frappe-bench && bench get-app payments http://akash:asdqwe123@113.193.30.98/payments/Payments-V14.git --branch dev-version-14
cd /home/frappe/frappe-bench && bench get-app elms http://akash:asdqwe123@113.193.30.98/lms/elms-V14.git
cd /home/frappe/frappe-bench && bench --site site1.local install-app erpnext
cd /home/frappe/frappe-bench && bench --site site1.local install-app formulation
cd /home/frappe/frappe-bench && bench --site site1.local install-app lms
cd /home/frappe/frappe-bench && bench --site site1.local install-app indian-compliance
cd /home/frappe/frappe-bench && bench --site site1.local install-app hrms
cd /home/frappe/frappe-bench && bench --site site1.local install-app payments
cd /home/frappe/frappe-bench && bench --site site1.local install-app elms
cd /home/frappe/frappe-bench && bench start 
EOF

bash