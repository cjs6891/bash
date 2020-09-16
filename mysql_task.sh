#!/bin/bash

function mysql_task
{
    message=""
    subject="$HOSTNAME - Galera[MySQL] Administration Console Update"
    from="no-reply@wshein.com"
    to1="cjs@wshein.com"
    to2=""
    option=NULL
    configuration_files="/opt/administration_console/configuration_files/mysql"
    clear
    echo -e "\e[93m#######################################"
    echo -e "\e[93m - Galera[MySQL] Administration Console"
    echo -e "\e[93m#######################################"
    echo -e "\e[93m---------------------------------------"

    until [ "$option" = "a" ] || \
        [ "$option" = "b" ] || \
        [ "$option" = "c" ] || \
        [ "$option" = "d" ] || \
        [ "$option" = "e" ] || \
        [ "$option" = "0" ]
    do
        echo "  a) Live Server"
        echo "  b) Transfer Load: galera210"
        echo "  c) Transfer Load: galera212"
        echo "  d) Transfer Load: galera214"
        echo "  e) Transfer Load: standalone33"
        echo "  0) Main Menu"

        echo -n "Enter Choice: "
        read option
        echo ""
        case $option in
            a ) cat /etc/nginx/nginx.conf\
             | grep -A1 -E "ffd491252a3fbe057f2bfe4a01ae348276dbd4b639421a1608195437f1f52225"\
             | grep -E "server" | awk '{print "Live Server: "$2}'
                sleep 5
                mysql_task
                ;;
            b ) sudo cp $configuration_files/galera210.conf /etc/nginx/nginx.conf
                sudo nginx -t && sudo nginx -s reload
                today=$(date '+%F %T')
                message="SSH Client: $SSH_CLIENT Transferred MySQL Load --to--> galera210 on $HOSTNAME at $today"
                if [[ $(echo $?) = 0 ]]
                then
                    echo $message
                    echo $message | mailx -r $from -s "$subject" $to1
                    echo $message | mailx -r $from -s "$subject" $to2

                fi
                sleep 5
                mysql_task
                ;;
            c ) sudo cp $configuration_files/galera212.conf /etc/nginx/nginx.conf
                sudo nginx -t && sudo nginx -s reload
                today=$(date '+%F %T')
                message="SSH Client: $SSH_CLIENT Transferred MySQL Load --to--> galera212 on $HOSTNAME at $today"
                if [[ $(echo $?) = 0 ]]
                then
                    echo $message
                    echo $message | mailx -r $from -s "$subject" $to1
                    echo $message | mailx -r $from -s "$subject" $to2
                fi
                sleep 5
                mysql_task
                ;;
            d ) sudo cp $configuration_files/galera214.conf /etc/nginx/nginx.conf
                sudo nginx -t && sudo nginx -s reload
                today=$(date '+%F %T')
                message="SSH Client: $SSH_CLIENT Transferred MySQL Load --to--> galera214 on $HOSTNAME at $today"
                if [[ $(echo $?) = 0 ]]
                then
                    echo $message
                    echo $message | mailx -r $from -s "$subject" $to1
                    echo $message | mailx -r $from -s "$subject" $to2
                fi
                sleep 5
                mysql_task
                ;;
            e ) sudo cp $configuration_files/standalone33.conf /etc/nginx/nginx.conf
                sudo nginx -t && sudo nginx -s reload
                today=$(date '+%F %T')
                message="SSH Client: $SSH_CLIENT Transferred MySQL Load --to--> standalone33 on $HOSTNAME at $today"
                if [[ $(echo $?) = 0 ]]
                then
                    echo $message
                    echo $message | mailx -r $from -s "$subject" $to1
                    echo $message | mailx -r $from -s "$subject" $to2
                fi
                sleep 5
                mysql_task
                ;;
            0 ) main_menu ;;
            * ) echo "Incorrect Choice"
                sleep 1
                mysql_task
                ;;
        esac
    done
}
