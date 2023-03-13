spawn mysql_secure_installation

expect "Enter current password for root (enter for none):"
send "pass\r"

expect "Switch to unix_socket authentication"
send "y\r"

expect "Change the root password?"
send "y\r"

expect "New password:"
send "root\r"

expect "Re-enter new password:"
send "root\r"

expect "Remove anonymous users?"
send "y\r"

expect "Disallow root login remotely?"
send "y\r"

expect "Remove test database and access to it?"
send "y\r"

expect "Reload privilege tables now?"
send "y\r"

expect eof