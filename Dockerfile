FROM	debian:10-slim as build

ENV	USER="casperklein"
ENV	NAME="netbox-scanner"
ENV	VERSION="0.1"

ENV	PACKAGES="python3 python3-pip nmap"

# Install packages
RUN	apt-get update \
&&	apt-get -y install $PACKAGES \
&&	rm -rf /var/lib/apt/lists/*

# Copy root filesystem
COPY	rootfs /

# install netbox-scanner
ADD	https://github.com/forkd/netbox-scanner/archive/master.tar.gz /
WORKDIR	/netbox-scanner
RUN	tar xzvf /master.tar.gz
WORKDIR	/netbox-scanner/netbox-scanner-master
RUN	pip3 install -r requirements.txt

# Cleanup
RUN	find /usr/ -name '*.pyc' -delete

# Build final image
FROM	scratch
COPY	--from=build / /

CMD	["/run.sh"]
