FROM debian:jessie

RUN awk '$1 ~ "^deb" { $3 = $3 "-backports"; print; exit }' /etc/apt/sources.list > /etc/apt/sources.list.d/backports.list

RUN apt-get update && \
    apt-get -t jessie-backports install -y \
	minidlna && \
    apt-get install -y \
	supervisor && \  
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD ./run.sh /run.sh

# add supervisor conf file for app
ADD supervisor_minidlna.conf /etc/supervisor/conf.d/minidlna.conf

EXPOSE 1900 8200

#ENTRYPOINT ["/run.sh"]
ENTRYPOINT ["/bin/bash"]
