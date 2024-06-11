IMG=imega/supercronic
IMAGE=imega/base-builder
TAG=latest
CWD=/data
ARCH=$(shell uname -m)

ifeq ($(ARCH),aarch64)
        ARCH=arm64
endif

ifeq ($(ARCH),x86_64)
        ARCH=amd64
endif

test: build
	docker run --rm -v $(CURDIR):/data -w /data $(IMG):$(TAG) -test crontab || exit 0

build: buildfs
	@docker build -t $(IMG):$(TAG) .

buildfs:
	@docker run --rm \
		-e CWD=$(CWD) \
		-v $(CURDIR)/runner:/runner \
		-v $(CURDIR)/buildfs:/build \
		-v $(CURDIR):$(CWD) \
		-e TAG=$(TAG) \
		imega/base-builder \
		--packages=" \
			busybox \
			tzdata \
			supercronic \
			xh \
		"

login:
	@docker login --username $(DOCKER_USER) --password $(DOCKER_PASS)

release: login build
	@docker tag $(IMAGE):$(TAG)-$(ARCH) $(IMAGE):latest-$(ARCH)
	@docker push $(IMAGE):$(TAG)-$(ARCH)
	@docker push $(IMAGE):latest-$(ARCH)

release-manifest: login
	@docker manifest create $(IMAGE):$(TAG) \
		$(IMAGE):$(TAG)-amd64 \
		$(IMAGE):$(TAG)-arm64
	@docker manifest create $(IMAGE):latest \
		$(IMAGE):latest-amd64 \
		$(IMAGE):latest-arm64
	@docker manifest push $(IMAGE):$(TAG)
	@docker manifest push $(IMAGE):latest

.PHONY: build
