export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
alias mysqlstart='sudo /usr/local/bin/mysqld -u root &'
alias mysqlstop='sudo /usr/local/bin/mysqladmin5 -u root -p shutdown'
alias pgstart="pg_ctl -D /usr/local/var/postgres -l logfile start'"
alias pgstop="pg_ctl -D /usr/local/var/postgres -l logfile stop'"

[[ $- == *i* ]]   &&   . "$HOME/Scripts/git-prompt/git-prompt.sh"

