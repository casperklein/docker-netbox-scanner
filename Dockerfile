FROM	debian:10-slim as build

ENV	PACKAGES="python3 python3-pip nmap"

SHELL   ["/bin/bash", "-o", "pipefail", "-c"]

ENV	GIT_USER="lopes"
ENV	GIT_REPO="netbox-scanner"
ENV	GIT_COMMIT="af65c252776127d2ab3505862fca7670e299c45c"
ENV	GIT_ARCHIVE="https://github.com/$GIT_USER/$GIT_REPO/archive/$GIT_COMMIT.tar.gz"

# Install packages
ENV	DEBIAN_FRONTEND=noninteractive
RUN	apt-get update \
&&	apt-get -y upgrade \
&&	apt-get -y install $PACKAGES \
&&	rm -rf /var/lib/apt/lists/*

# Download source
WORKDIR	/$GIT_REPO
ADD	$GIT_ARCHIVE /
RUN	tar --strip-component 1 -xzvf /$GIT_COMMIT.tar.gz && rm /$GIT_COMMIT.tar.gz \
&&	mkdir logs

# Install dependencies
RUN	pip3 install --no-cache-dir -r requirements.txt

# Cleanup
RUN	find /usr/ -name '*.pyc' -delete

# Copy root filesystem
COPY	rootfs /

# Build final image
FROM	scratch

ARG	VERSION
ENV	Version=$VERSION

CMD	["/run.sh"]

COPY	--from=build / /
