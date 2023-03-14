set app [lindex $argv 0];
set repoLink [lindex $argv 1];
set branch [lindex $argv 2];

spawn bench get-app $app $repoLink --branch $branch

expect "Username for 'http://113.193.30.98'"
send "akash\r"

expect "Password for 'http://akash@113.193.30.98'"
send "asdqwe123\r"