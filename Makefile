DOCKER := $(shell { command -v podman || command -v docker; })
TIMESTAMP := $(shell date -u +"%Y%m%d%H%M")
# Mark uncommitted builds with an x so the firmware filename (and the
# version macro, via get_version_local.sh) never impersonates a commit.
COMMIT := $(shell git rev-parse --short HEAD 2>/dev/null)$(shell git status --porcelain --untracked-files=no -- . ':!config/version.dtsi' | grep -q . && echo x)
ifeq ($(shell uname),Darwin)
SELINUX1 :=
SELINUX2 :=
else
SELINUX1 := :z
SELINUX2 := ,z
endif

.PHONY: all reset clean_firmware clean_image clean

# Local display module (Street Fighter nice!view art). Kept OUT of this
# repo; when the directory exists it is mounted into the build container
# and build.sh swaps the stock nice_view shield for it.
DISPLAY_MODULE := $(HOME)/src/nice-view-keyball
ifneq ($(wildcard $(DISPLAY_MODULE)),)
MODULE_MOUNT := -v $(DISPLAY_MODULE):/modules/nice-view-keyball:ro$(SELINUX2)
else
MODULE_MOUNT :=
endif

all:
	$(shell bin/get_version_local.sh kb44 >> /dev/null)
	$(DOCKER) build --tag zmk-keyball44 --file Dockerfile .
	$(DOCKER) run --rm --name zmk-keyball44 \
		-v $(PWD)/firmware:/app/firmware$(SELINUX1) \
		-v $(PWD)/config:/app/config:ro$(SELINUX2) \
		$(MODULE_MOUNT) \
		-e TIMESTAMP=$(TIMESTAMP) \
		-e COMMIT=$(COMMIT) \
		zmk-keyball44
	git checkout config/version.dtsi

reset:
	$(shell bin/get_version_local.sh kb44 >> /dev/null)
	$(DOCKER) build --tag zmk-keyball44 --file Dockerfile .
	$(DOCKER) run --rm --name zmk-keyball44 \
		-v $(PWD)/firmware:/app/firmware$(SELINUX1) \
		-v $(PWD)/config:/app/config:ro$(SELINUX2) \
		-e TIMESTAMP=$(TIMESTAMP) \
		-e COMMIT=$(COMMIT) \
		-e BUILD_SETTINGS_RESET=true \
		zmk-keyball44
	git checkout config/version.dtsi

clean_firmware:
	rm -f firmware/*.uf2

clean_image:
	$(DOCKER) image rm zmk-keyball44 docker.io/zmkfirmware/zmk-build-arm:stable

clean: clean_firmware clean_image
