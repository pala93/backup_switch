
#!/bin/bash

count=0
ip=(

    '1.1.1.1'   #D-link ip-addresses
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
echo "enable admin"
sleep 1
echo "ADMIN PASS"
sleep 1
echo "upload cfg_toTFTP 4.4.4.4 dest_file $j.cfg" # (4.4.4.4)ip tftp server
sleep 5
echo "quit"
sleep 1
echo "quit"
) | /usr/bin/telnet $j >/dev/null
/bin/mv /TFTP_DIRECTORY/$j.cfg /BACKUP_DIRECTORY/$j/`date +%Y-%m-%d`.cfg >/dev/null
cd /BACKUP_DIRECTORY/$j/
find . -name "20??-??-??.cfg" -mtime +30 -type f -delete
done

exit

### Ubuntu server 16.04 Work in D-link DGS-3120, DGS-3420, DGS_3000 and etc DGS series. -mtime +30 - saved backup < 30 days. Else - backups  deleted.

