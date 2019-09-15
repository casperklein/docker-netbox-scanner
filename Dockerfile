FROM    debian:10-slim as build

ENV	PACKAGES="python3 python3-pip nmap unzip"

# Install packages
RUN     apt-get update \
&&	apt-get -y install $PACKAGES \
&&	rm -rf /var/lib/apt/lists/*

# Copy root filesystem
COPY	rootfs /

# install netbox-scanner
ADD	https://github.com/forkd/netbox-scanner/archive/master.zip /
RUN	unzip master.zip -d netbox-scanner
WORKDIR	/netbox-scanner/netbox-scanner-master
RUN	pip3 install -r requirements.txt

# Build final image
RUN	rm -rf /var/lib/apt/lists/*
FROM	scratch
COPY	--from=build / /

CMD	["/run.sh"]
