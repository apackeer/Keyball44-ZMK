DOCKER := $(shell { command -v podman || command -v docker; })
TIMESTAMP := $(shell date -u +"%Y%m%d%H%M")
COMMIT := $(shell git rev-parse --short HEAD 2>/dev/null)
ifeq ($(shell uname),Darwin)
SELINUX1 :=
SELINUX2 :=
else
SELINUX1 := :z
SELINUX2 := ,z
endif

.PHONY: all reset clean_firmware clean_image clean

all:
	$(DOCKER) build --tag zmk-keyball44 --file Dockerfile .
	$(DOCKER) run --rm -it --name zmk-keyball44 \
		-v $(PWD)/firmware:/app/firmware$(SELINUX1) \
		-v $(PWD)/config:/app/config:ro$(SELINUX2) \
		-e TIMESTAMP=$(TIMESTAMP) \
		-e COMMIT=$(COMMIT) \
		zmk-keyball44

reset:
	$(DOCKER) build --tag zmk-keyball44 --file Dockerfile .
	$(DOCKER) run --rm -it --name zmk-keyball44 \
		-v $(PWD)/firmware:/app/firmware$(SELINUX1) \
		-v $(PWD)/config:/app/config:ro$(SELINUX2) \
		-e TIMESTAMP=$(TIMESTAMP) \
		-e COMMIT=$(COMMIT) \
		-e BUILD_SETTINGS_RESET=true \
		zmk-keyball44

clean_firmware:
	rm -f firmware/*.uf2

clean_image:
	$(DOCKER) image rm zmk-keyball44 docker.io/zmkfirmware/zmk-build-arm:stable

clean: clean_firmware clean_image
