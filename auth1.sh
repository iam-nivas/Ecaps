spawn bench init frappe-bench --frappe-branch dev-version-14 --frappe-path http://113.193.30.98/frappe/Frappe-V14.git


expect "Username for 'http://113.193.30.98':"
send "akash\r"

expect "Password for 'http://akash@113.193.30.98'"
send "asdqwe123\r"

expect "Username for 'http://113.193.30.98'"
send "akash\r"

expect "Password for 'http://akash@113.193.30.98'"
send "asdqwe123\r"