#!/bin/bash

ip=(
    '1.1.1.1'		## Ip address bdcom olt`s
    '2.2.2.2'
    '3.3.3.3'
    )

for j in ${ip[@]}
do

(
sleep 1
echo "login"
sleep 1
echo "pass"
sleep 1
echo "enable"
sleep 1
echo "copy startup-config tftp 6.6.6.6"		# ip address  ftp server
sleep 1
echo "$j.cfg"
sleep 1
echo "copy flash tftp 6.6.6.6"
sleep 1
echo "config.db"
sleep 1
echo "$j.db"
sleep 1
echo "copy flash tftp 6.6.6.6"
sleep 1
echo "ifindex-config"
sleep 1
echo "$j.ifindex"
sleep 1
echo "quit"
sleep 1
echo "quit"
) | /usr/bin/telnet $j >/dev/null
/bin/mv /TFTP_DIRECTORY/$j.cfg /BACKUP_SAVED_DIRECTORY/$j/`date +%Y-%m-%d`.cfg >/dev/null
/bin/mv /TFTP_DIRECTORY/$j.db /BACKUP_SAVED_DIRECTORY/$j/`date +%Y-%m-%d`.db >/dev/null
/bin/mv /TFTP_DIRECTORY/$j.ifindex /BACKUP_SAVED_DIRECTORY/$j/`date +%Y-%m-%d`.ifindex >/dev/null
cd /BACKUP_SAVED_DIRECTORY/$j/
find . -name "20??-??-??.cfg" -mtime +30 -type f -delete
find . -name "20??-??-??.db" -mtime +30 -type f -delete
find . -name "20??-??-??.ifindex" -mtime +30 -type f -delete
done

exit

### Ubuntu server 16.04   Working on bdcom p3310b, p3310c -mtime +30 - saved backup < 30 days. Else - backups  deleted.
