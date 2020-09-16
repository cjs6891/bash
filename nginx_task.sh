#!/bin/bash

function nginx_task
{
    message=""
    subject="$HOSTNAME - Nginx Administration Console Update"
    from="no-reply@wshein.com"
    to1="cjs@wshein.com"
    to2=""
    option=NULL
    clear
    echo -e "\e[93m###############################"
    echo -e "\e[93m - Nginx Administration Console"
    echo -e "\e[93m###############################"
    echo -e "\e[93m-------------------------------"

    until [ "$option" = "a" ] || \
        [ "$option" = "b" ] || \
        [ "$option" = "c" ] || \
        [ "$option" = "d" ] || \
        [ "$option" = "9" ] || \
        [ "$option" = "0" ]
    do
        echo "  a) Nginx Status"
        echo "  b) Restart Nginx"
        echo "  c) Start Nginx"
        echo "  d) Stop Nginx"
        echo -e "\e[31m  9) SIGKILL (KILL)"
        echo -e "\e[93m  0) Main Menu"

        echo -n "Enter Choice: "
        read option
        echo ""
        case $option in
            a ) sudo systemctl status nginx.service
                sleep 5
                nginx_task
                ;;
            b ) sudo nginx -t && sudo systemctl restart nginx.service
                today=$(date '+%F %T')
                message="SSH Client: $SSH_CLIENT Restarted Nginx on Host: $HOSTNAME at $today"
                if [[ $(echo $?) = 0 ]]
                then
                    echo $message
                    echo $message | mailx -r $from -s "$subject" $to1
                    echo $message | mailx -r $from -s "$subject" $to2
                fi
                sleep 5
                nginx_task
                ;;
            c ) sudo nginx -t && sudo systemctl start nginx.service
                today=$(date '+%F %T')
                message="SSH Client: $SSH_CLIENT Started Nginx on Host: $HOSTNAME at $today"
                if [[ $(echo $?) = 0 ]]
                then
                    echo $message
                    echo $message | mailx -r $from -s "$subject" $to1
                    echo $message | mailx -r $from -s "$subject" $to2
                fi
                sleep 5
                nginx_task
                ;;
            d ) sudo systemctl stop nginx.service
                today=$(date '+%F %T')
                message="SSH Client: $SSH_CLIENT Stopped Nginx on Host: $HOSTNAME at $today"
                if [[ $(echo $?) = 0 ]]
                then
                    echo $message
                    echo $message | mailx -r $from -s "$subject" $to1
                    echo $message | mailx -r $from -s "$subject" $to2
                fi
                sleep 5
                nginx_task
                ;;
            9 ) sudo /usr/bin/killall -9 nginx
                today=$(date '+%F %T')
                message="SSH Client: $SSH_CLIENT SIGKILL (KILL) Nginx on Host: $HOSTNAME at $today"
                echo $message
                echo $message | mailx -r $from -s "$subject" $to1
                echo $message | mailx -r $from -s "$subject" $to2
                sleep 5
                nginx_task
                ;;
            0 ) main_menu ;;
            * ) echo "Incorrect Choice"
                sleep 1
                nginx_task
                ;;
        esac
    done
}
