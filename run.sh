#!/bin/bash

for VAR in `env`; do
    if [[ $VAR =~ ^MINIDLNA_ ]]; then
	KEY=`echo ${VAR:9} | tr '[:upper:]' '[:lower:]' | cut -d "=" -f 1`
	VALUE=`echo ${VAR:9} | tr '[:upper:]' '[:lower:]' | cut -d "=" -f 2`
	echo sed -i -e "s|^.*$KEY=.*$|$KEY=$VALUE|g" /etc/minidlna.conf
	sed -i -e "s|^.*$KEY=.*$|$KEY=$VALUE|g" /etc/minidlna.conf
    fi
done

/usr/sbin/minidlnad -S 

