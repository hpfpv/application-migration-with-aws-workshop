#!/bin/bash

sudo mysql -u root -pAWSRocksSince2006

GRANT REPLICATION CLIENT ON *.* to 'wordpress-user';
GRANT REPLICATION SLAVE ON *.* to 'wordpress-user';
GRANT SUPER ON *.* to 'wordpress-user';
exit


sudo su - 
mkdir /var/lib/mysql/binlogs
chown -R mysql:mysql /var/lib/mysql/binlogs
exit


sudo su -
cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/my.cnf
chown -R mysql:mysql /etc/mysql/my.cnf
nano /etc/mysql/my.cnf

Then add the following information under the [mysqld] section, save the file and exit nano:
server_id=1
log-bin=/var/lib/mysql/binlogs/log
binlog_format=ROW
expire_logs_days=1
binlog_checksum=NONE
binlog_row_image=FULL
log_slave_updates=TRUE
performance_schema=ON


sudo service mysql restart

sudo mysql -u root -pAWSRocksSince2006

select variable_value as "BINARY LOGGING STATUS (log-bin) :: "
 from performance_schema.global_variables where variable_name='log_bin';

select variable_value as "BINARY LOG FORMAT (binlog_format) :: "
 from performance_schema.global_variables where variable_name='binlog_format';

exit


