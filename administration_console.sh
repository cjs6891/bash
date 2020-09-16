#!/bin/bash

## Install Instructions
# useradd --uid 58000 --gid 100 --no-create-home --shell /opt/administration_console/administration_console.sh merlin

## visudo
## HeinOnline Administration Console
#Cmnd_Alias APACHE_TASKS = /usr/sbin/apachectl configtest, /usr/sbin/apachectl restart, /usr/sbin/apachectl start, /usr/sbin/apachectl stop, /usr/bin/systemctl status httpd.service, /usr/bin/killall -9 httpd
#Cmnd_Alias MYSQL_TASKS = /usr/bin/cp /opt/administration_console/configuration_files/mysql/galera210.conf /etc/nginx/nginx.conf, /usr/bin/cp /opt/administration_console/configuration_files/mysql/galera212.conf /etc/nginx/nginx.conf, /usr/bin/cp /opt/administration_console/configuration_files/mysql/galera214.conf /etc/nginx/nginx.conf, /usr/bin/cp /opt/administration_console/configuration_files/mysql/standalone33.conf /etc/nginx/nginx.conf
#Cmnd_Alias NGINX_TASKS =  /usr/sbin/nginx -s reload, /usr/sbin/nginx -t, /usr/bin/systemctl restart nginx.service, /usr/bin/systemctl start nginx.service, /usr/bin/systemctl status nginx.service, /usr/bin/systemctl stop nginx.service, /usr/bin/killall -9 nginx
#Cmnd_Alias SOLR_TASKS = /usr/bin/cp /opt/administration_console/configuration_files/solr/solr210.conf /etc/nginx/conf.d/solr.conf, /usr/bin/cp /opt/administration_console/configuration_files/solr/solr212.conf /etc/nginx/conf.d/solr.conf, /usr/bin/cp /opt/administration_console/configuration_files/solr/solr214.conf /etc/nginx/conf.d/solr.conf, /usr/bin/cp /opt/administration_console/configuration_files/solr/standalone33.conf /etc/nginx/conf.d/solr.conf

#merlin        ALL=(ALL)       NOPASSWD: APACHE_TASKS, MYSQL_TASKS, NGINX_TASKS, SOLR_TASKS

# - - - - - 

SSH_CLIENT=$(env | grep -E "SSH_CLIENT\=" | awk -F = '{print $2}' | awk '{print $1}')
HOSTNAME=$(hostname)
. /opt/administration_console/apache_task.sh
. /opt/administration_console/mysql_task.sh
. /opt/administration_console/nginx_task.sh
. /opt/administration_console/solr_task.sh

while true
do
    # - - - - -
    trap "" SIGINT SIGQUIT SIGTSTP

    function main_menu
    {
        option=NULL
        clear
        echo -e "\e[39m###################################"
        echo -e "\e[39m HeinOnline Administration Console"
        echo -e "\e[39m###################################"
        echo -e "\e[39m-----------------------------------"

        until [ "$option" = "1" ] || \
            [ "$option" = "2" ] || \
            [ "$option" = "3" ] || \
            [ "$option" = "4" ] || \
            [ "$option" = "0" ]
        do
            echo "  1) Apache Service"
            echo "  2) MySQL Traffic"
            echo "  3) Nginx Service"
            echo "  4) Solr Traffic"
            echo "  0) Exit"

            echo -n "Enter Choice: "
            read option
            echo ""
            case $option in
                1 ) apache_task ;;
                2 ) mysql_task ;;
                3 ) nginx_task ;;
                4 ) solr_task ;;
                0 ) exit ;;
                * ) echo "Incorrect Choice";
            esac
        done
    }

    main_menu
done
