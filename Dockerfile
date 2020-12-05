FROM	debian:10-slim as build

ENV	USER="casperklein"
ENV	NAME="netbox-scanner"
ENV	VERSION="0.1.1"

ENV	PACKAGES="python3 python3-pip nmap"

ENV	GIT_COMMIT="438016caea3e975ce2cae34c443d661ee7b66b20"
ENV	GIT_ARCHIVE="https://github.com/lopes/netbox-scanner/archive/$GIT_COMMIT.tar.gz"

# Install packages
RUN	apt-get update \
&&	apt-get -y install $PACKAGES \
&&	rm -rf /var/lib/apt/lists/*

# Copy root filesystem
COPY	rootfs /

# install netbox-scanner
ADD	$GIT_ARCHIVE /
WORKDIR	/netbox-scanner
RUN	tar xzvf /$GIT_COMMIT.tar.gz
WORKDIR	/netbox-scanner/netbox-scanner-$GIT_COMMIT
RUN	pip3 install -r requirements.txt

# Cleanup
RUN	find /usr/ -name '*.pyc' -delete

# Build final image
FROM	scratch
COPY	--from=build / /

CMD	["/run.sh"]
