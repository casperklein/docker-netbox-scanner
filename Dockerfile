FROM	debian:12-slim AS build

ARG	GIT_USER="lopes"
ARG	GIT_REPO="netbox-scanner"
ARG	GIT_COMMIT="af65c252776127d2ab3505862fca7670e299c45c"
ARG	GIT_ARCHIVE="https://github.com/$GIT_USER/$GIT_REPO/archive/$GIT_COMMIT.tar.gz"

WORKDIR	/netbox-scanner
ADD	$GIT_ARCHIVE /
RUN	tar --strip-component 1 -xzvf /$GIT_COMMIT.tar.gz && rm /$GIT_COMMIT.tar.gz \
&&	mkdir logs

COPY	rootfs /

ARG	PACKAGES="patch python3-venv nmap"

RUN	apt-get update \
&&	apt-get -y --no-install-recommends install $PACKAGES \
&&	rm -rf /var/lib/apt/lists/*

# DNS patch
RUN	patch -i /patches/__init__.py.patch	/netbox-scanner/nbs/__init__.py
RUN	patch -i /patches/nmap.py.patch		/netbox-scanner/nbs/nmap.py

# If this is set to a non-empty string, Python won’t try to write .pyc files on the import of source modules.
ENV	PYTHONDONTWRITEBYTECODE=1
# Show python output immediately, not buffered.
ENV	PYTHONUNBUFFERED=1

# create and use python virtual environment
ENV	VIRTUAL_ENV=/netbox-scanner/venv
RUN	python3 -m venv "$VIRTUAL_ENV"
ENV	PATH="$VIRTUAL_ENV/bin:$PATH"

# Install dependencies
RUN	pip3 install --no-cache-dir -r requirements.txt

# Copy necessary files
COPY	rootfs/run.sh /

# Build final image
FROM	scratch

# If this is set to a non-empty string, Python won’t try to write .pyc files on the import of source modules.
ENV	PYTHONDONTWRITEBYTECODE=1
# Show python output immediately, not buffered.
ENV	PYTHONUNBUFFERED=1

# use python virtual environment
ENV	VIRTUAL_ENV=/netbox-scanner/venv
ENV	PATH="$VIRTUAL_ENV/bin:$PATH"

ARG	VERSION="unknown"

LABEL	org.opencontainers.image.description="Dockerized version of netbox-scanner. Scan networks and add them to Netbox."
LABEL	org.opencontainers.image.source="https://github.com/casperklein/docker-netbox-scanner/"
LABEL	org.opencontainers.image.title="docker-netbox-scanner"
LABEL	org.opencontainers.image.version="$VERSION"

COPY	--from=build / /

CMD	["/run.sh"]

WORKDIR	/netbox-scanner
