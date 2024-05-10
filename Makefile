IMAGE=ghcr.io/densuke/densukest/kdi
TAG=main

all: build

build:
	docker build -t $(IMAGE):$(TAG) -f image/Dockerfile .

push: build
	docker buildx build --platform linux/amd64,linux/arm64 -t $(IMAGE):$(TAG) --push -f image/Dockerfile .
