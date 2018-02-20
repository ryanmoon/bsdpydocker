#!/bin/sh -x

##############
# START NGINX
##############

sleep 1
nginx

########
# TFTPD
########

sleep 1
/usr/sbin/in.tftpd -l --permissive /nbi

#cd /bsdpy
#./bsdpserver.py -i ${DOCKER_BSDPY_IFACE} -r ${DOCKER_BSDPY_PROTO} -p ${DOCKER_BSDPY_PATH} &
#sleep 2
#tail -f /var/log/nginx-error.log

########
# BSDPY
########

/usr/bin/env python /bsdpy/bsdpserver.py -i ${DOCKER_BSDPY_IFACE} &

tail -f /var/log/bsdpserver.log
