# all targets are phony (no files to check)
.PHONY: build clean scan push

SHELL = /bin/bash

IMAGE := $(shell jq -er '.image' < config.json)
TAG := $(shell jq -er '"\(.image):\(.version)"' < config.json)

build:
	@./build.sh

clean:
	@echo "Removing Docker images.."
	docker rmi "$(TAG)"; \
	docker rmi "$(IMAGE):latest"

scan:
	@./scan.sh

push:
	@echo "Pushing image to Docker Hub.."
	docker push "$(TAG)"
	docker push "$(IMAGE):latest"
