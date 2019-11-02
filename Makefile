# all targets are phony (no files to check)
.PHONY: build clean scan push

build:
	./build.sh

clean:
	USER=$$(grep -P 'ENV\s+USER=".+?"' Dockerfile | cut -d'"' -f2) && \
	NAME=$$(grep -P 'ENV\s+NAME=".+?"' Dockerfile | cut -d'"' -f2) && \
	VERSION=$$(grep -P 'ENV\s+VERSION=".+?"' Dockerfile | cut -d'"' -f2) && \
	docker rmi $$USER/$$NAME:$$VERSION

scan:
	./scan.sh

push:
	USER=$$(grep -P 'ENV\s+USER=".+?"' Dockerfile | cut -d'"' -f2) && \
	NAME=$$(grep -P 'ENV\s+NAME=".+?"' Dockerfile | cut -d'"' -f2) && \
	VERSION=$$(grep -P 'ENV\s+VERSION=".+?"' Dockerfile | cut -d'"' -f2) && \
	docker push $$USER/$$NAME:$$VERSION
