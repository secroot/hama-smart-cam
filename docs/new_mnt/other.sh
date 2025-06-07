#!/bin/sh

LOGFILE=/tmp/mnt/sdcard/myhack.log

echo "other.sh started" >> $LOGFILE

echo "ps" >> $LOGFILE
ps >> $LOGFILE

echo "whoami" >> $LOGFILE
whoami >> $LOGFILE 2>&1

echo "netstat before telnet" >> $LOGFILE
netstat -tulpn >> $LOGFILE 2>&1

telnetd

sleep 2

echo "netstat after telnet" >> $LOGFILE
netstat -tulpn >> $LOGFILE 2>&1

echo "ps" >> $LOGFILE
ps >> $LOGFILE

echo "ls -l /" >> $LOGFILE
ls -l / >> $LOGFILE

cp -r /bin/ /tmp/mnt/sdcard/
cp -r /config/ /tmp/mnt/sdcard/
cp -r /config_bak/ /tmp/mnt/sdcard/
cp -r /dev/ /tmp/mnt/sdcard/
cp -r /etc/ /tmp/mnt/sdcard/
cp -r /lib/ /tmp/mnt/sdcard/
cp -r /root/ /tmp/mnt/sdcard/
cp -r /sbin/ /tmp/mnt/sdcard/
cp -r /stone/ /tmp/mnt/sdcard/
cp -r /usr/ /tmp/mnt/sdcard/
cp -r /var/ /tmp/mnt/sdcard/

ls -l /tmp/ >> $LOGFILE
ls -l /mnt/ >> $LOGFILE

echo "other.sh ended" >> $LOGFILE
