FROM debian:jessie

RUN awk '$1 ~ "^deb" { $3 = $3 "-backports"; print; exit }' /etc/apt/sources.list > /etc/apt/sources.list.d/backports.list

RUN apt-get update && \
    apt-get -t jessie-backports install -y \
	minidlna && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD ./run.sh /run.sh

ADD minidlna.conf /etc/minidlna.conf

VOLUME ["/media]
VOLUME ["/database]

EXPOSE 1900 8200

ENTRYPOINT ["/run.sh"]
