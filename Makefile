IMAGE=ghcr.io/densuke/densukest/kdi
TAG=main
DESTDIR=/usr/local/bin

all: build

build:
	docker build -t $(IMAGE):$(TAG) -f image/Dockerfile .

install: build $(DESTDIR)/kadai
