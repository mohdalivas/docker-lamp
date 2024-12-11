#!/bin/bash
# service ssh start
# service apache2 start
cron
/usr/sbin/apache2ctl -D FOREGROUND
# && tail -f /var/log/cron.log
tail -f /dev/null
