#!/bin/bash/

count=0
ip=('1.1.1.1'    #Brocade ip addresses
    '2.2.2.2'
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

echo "copy startup-config tftp 4.4.4.4 $j.cfg"   # (4.4.4.4)Ip address tftp server
sleep 1
echo "quit"
sleep 1
echo "quit"
) | /usr/bin/telnet $j >/dev/null
/bin/mv /TFTP_DIRECTORY/$j.cfg /BACKUP_SAVE_DIRECTORY/$j/`date +%Y-%m-%d`.cfg >/dev/null
cd /BACKUP_SAVE_DIRECTORY/$j/
find . -name "20??-??-??.cfg" -mtime +30 -type f -delete
done

exit

### Ubuntu server 16.04  Brocade ICX6610 -mtime +30 - saved backup < 30 days. Else - backups  deleted.
