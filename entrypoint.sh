#!/bin/sh
set -e

/usr/sbin/csf --initup
/usr/sbin/lfd

exec tail -f /var/log/lfd.log
