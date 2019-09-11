HISTSIZE=2048
HISTTIMEFORMAT="%F %T - "
HISTCONTROL=ignorespace

 - Bash Prompt:
┌──[root@server1]-[/var/www/html]
└───#

Without Color(s):
PS1="┌──[\u@\h]-[\w]\n└───# "

With Color(s):
PS1="\[\033[0;31m\]┌──[\[\033[0;39m\]\u\[\033[0;32m\]@\[\033[0;33m\]\h\[\033[0;31m\]]-[\[\033[0;32m\]\w\[\033[0;31m\]]\n└───\[\033[0;32m\]# \[\033[0m\]"
