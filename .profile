# MacPorts Installer addition on 2012-04-02_at_12:31:28: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

alias apache2ctl='sudo /opt/local/apache2/bin/apachectl'
alias mysqlstart='sudo /opt/local/bin/mysqld_safe5 &'
alias mysqlstop='/opt/local/bin/mysqladmin5 -u root -p shutdown'
alias mysqladmin='/opt/local/bin/mysqladmin5'
alias mysql='/opt/local/bin/mysql5'

[[ $- == *i* ]]   &&   . "$HOME/Scripts/git-prompt/git-prompt.sh"