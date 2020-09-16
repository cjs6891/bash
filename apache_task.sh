#!/bin/bash

function apache_task
{
    message=""
    subject="$HOSTNAME - Apache Administration Console Update"
    from="no-reply@wshein.com"
    to1="cjs@wshein.com"
    to2=""
    option=NULL
    clear
    echo -e "\e[93m################################"
    echo -e "\e[93m - Apache Administration Console"
    echo -e "\e[93m################################"
    echo -e "\e[93m--------------------------------"

    until [ "$option" = "a" ] || \
        [ "$option" = "b" ] || \
        [ "$option" = "c" ] || \
        [ "$option" = "d" ] || \
        [ "$option" = "e" ] || \
        [ "$option" = "f" ] || \
        [ "$option" = "9" ] || \
        [ "$option" = "0" ]
    do
        echo "  a) Apache Status"
        echo "  b) Restart Apache"
        echo "  c) Start Apache"
        echo "  d) Stop Apache"
        echo -e "\e[31m  9) SIGKILL (KILL)"
        echo -e "\e[93m  0) Main Menu"

        echo -n "Enter Choice: "
        read option
        echo ""
        case $option in
            a ) sudo systemctl status httpd.service
                sleep 5
                apache_task
                ;;
            b ) sudo apachectl configtest && sudo apachectl restart
                today=$(date '+%F %T')
                message="SSH Client: $SSH_CLIENT Restarted Apache on Host: $HOSTNAME at $today"
                if [[ $(echo $?) = 0 ]]
                then
                    echo $message
                    echo $message | mailx -r $from -s "$subject" $to1
                    echo $message | mailx -r $from -s "$subject" $to2
                fi
                sleep 5
                apache_task
                ;;
            c ) sudo apachectl configtest && sudo apachectl start
                today=$(date '+%F %T')
                message="SSH Client: $SSH_CLIENT Started Apache on Host: $HOSTNAME at $today"
                if [[ $(echo $?) = 0 ]]
                then
                    echo $message
                    echo $message | mailx -r $from -s "$subject" $to1
                    echo $message | mailx -r $from -s "$subject" $to2
                fi
                sleep 5
                apache_task
                ;;
            d ) sudo apachectl stop
                today=$(date '+%F %T')
                message="SSH Client: $SSH_CLIENT Stopped Apache on Host: $HOSTNAME at $today"
                if [[ $(echo $?) = 0 ]]
                then
                    echo $message
                    echo $message | mailx -r $from -s "$subject" $to1
                    echo $message | mailx -r $from -s "$subject" $to2
                fi
                sleep 5
                apache_task
                ;;
            9 ) sudo killall -9 httpd
                today=$(date '+%F %T')
                message="SSH Client: $SSH_CLIENT SIGKILL (KILL) Apache on Host: $HOSTNAME at $today"
                echo $message
                echo $message | mailx -r $from -s "$subject" $to1
                echo $message | mailx -r $from -s "$subject" $to2
                sleep 5
                apache_task
                ;;
            0 ) main_menu ;;
            * ) echo "Incorrect Choice"
                sleep 1
                apache_task
                ;;
        esac
    done
}
