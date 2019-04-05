#!/bin/bash

if [  ! -f /root/confmaltrailok.tmp ]; then
	if  [ -z "$PASSWD" ] ;then
		PASSWD=changeme!
	fi
	passwdsha=${echo -n "$PASSWD" | sha256sum | cut -d " " -f 1}
	sed -i "s/9ab3cd9d67bf49d01f6a2e33d0bd9bc804ddbe6ce1ff5d219c42624851db5dbc/$passwdsha/g" /root/maltrail/maltrail.conf
	touch /root/confmaltrailok.tmp
fi
cd /root/maltrail
git pull
python ./sensor.py &
python ./server.py
