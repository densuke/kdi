IMAGE=ghcr.io/densuke/densukest/kdi
TAG=main
DESTDIR=/usr/local/bin

all: build

check_in_devcontainer:
	@if echo "$${PATH}" | grep -q 'vscode-server'; then \
		echo "DevContainer環境では実行をブロックしています。"; \
		echo "GitHub Actionsにさせてください"; \
		exit 1; \
	fi

build: setup_builder
	docker buildx build -t $(IMAGE):$(TAG) -f image/Dockerfile --load .
setup_builder:
	if ! docker buildx ls --format '{{.Name}}' | sort -u | grep -q kdi; then \
		docker buildx create --use --platform=linux/amd64,linux/arm64 --name=kdi; \
	fi
#push: check_in_devcontainer build
#	docker buildx build --platform linux/amd64,linux/arm64 -t $(IMAGE):$(TAG) --push -f image/#Dockerfile .
install: build $(DESTDIR)/kadai

$(DESTDIR)/kadai: bin/kadai
	sudo install -o root - root -m 0755 -v bin/kadai $(DESTDIR)/kadai
