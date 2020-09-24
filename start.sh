Development System Setup

#!/bin/bash

#setenforce 0
#systemctl stop firewalld.service  && systemctl disable firewalld.service
#yum clean all
#yum -y update
#yum -y install epel-release.noarch
#yum -y install htop lsof net-tools ntp strace vim wget
#systemctl start ntpd.service
#systemctl enable ntpd.service
#yum -y groupinstall "Development Tools"
#yum -y install samba
#systemctl start smb.service
#systemctl enable smb.service
#yum install -y httpd.x86_64 httpd-devel.x86_64 httpd-manual.noarch httpd-tools.x86_64
#yum -y install cronolog
#systemctl start httpd.service
#systemctl enable httpd.service

##/etc/security/limits.conf
## Append:
## *       soft    nofile  1000000
## *       hard    nofile  1000000

### Galera MySQL Cluster - START
## CentOS7.x
## MySQL 5.6

#cat <<EOF > /etc/yum.repos.d/galera.repo
#[galera]
#name = Galera
#baseurl = https://releases.galeracluster.com/galera-3/centos/7/x86_64/
#gpgkey = https://releases.galeracluster.com/GPG-KEY-galeracluster.com
#gpgcheck = 1

#[mysql-wsrep]
#name = MySQL-wsrep
#baseurl =  https://releases.galeracluster.com/mysql-wsrep-5.6/centos/7/x86_64/
#gpgkey = https://releases.galeracluster.com/GPG-KEY-galeracluster.com
#gpgcheck = 1
#EOF

#yum -y remove mariadb-libs
#yum -y install galera-3 mysql-wsrep-5.6 policycoreutils-python socat
#yum -y install percona-xtrabackup.x86_64
#systemctl start mysql.service
#systemctl enable mysql.service

## RANDOM MySQL root password
## /root/.mysql_secret

#mysql_secure_installation

## Configuration dependent, these directories may be needed
#mkdir /var/log/mysql
#chown mysql:mysql /var/log/mysql/
#mkdir /var/run/mysqld
#chown mysql:mysql /var/run/mysqld

## CentOS 7.x
## MySQL 5.6
## On the first node, start MySQL with the "--wsrep-new-cluster" option
## /usr/bin/mysqld_safe --wsrep-new-cluster
## Let the command run in the foreground
## On the remaining cluster nodes start the MySQL service
## systemctl start mysql.service

## After the cluster has been fully formed, stop MySQL on the first node using 'kill -9 PIDs'.
## To find the PIDs run the following : ps aux | grep mysql | grep -v grep | awk '{print $2}'
## kill -9 37533 38278
## After the processes have been terminated start MySQL via systemd:
## systemctl start mysql.service
## Verify cluster status:
## mysql -e "SHOW GLOBAL STATUS LIKE 'wsrep%';"

### Galera MySQL Cluster - END


### Remi's RPM Repository - START
## CentOS 7.x
## PHP 7.4

#yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
#yum -y install yum-utils
#yum-config-manager --enable remi
#yum-config-manager --enable remi-php74
#yum clean all
#yum -y install php.x86_64 php-mysql.x86_64 phpMyAdmin.noarch

## Append authorized IPs to: /etc/httpd/conf.d/phpMyAdmin.conf
## Require ip 10.0.0.0/8
## Require ip 172.16.0.0/12
## Require ip 192.168.0.0/16

### Remi's RPM Repository - END


### Postfix - START
#yum -y install mailx postfix
#vim /etc/postfix/main.cf
#systemctl start postfix.service
#systemctl enable postfix.service

### Postfix - END
