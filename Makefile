help:
ifneq (, $(shell which gum))
	@cat README.md | gum format
else
	@cat README.md
endif
	@echo


version := 2022.11
build_root = $(PWD)/build/$*
sync_args := -rvc --timeout 2 --exclude '/.git' --filter=':- .gitignore'

include site.mk

ifdef jobs
override jobs := -j$(jobs)
endif


build:
	mkdir -p build

build/root: build
	git -c advice.detachedHead=false \
	clone git://git.buildroot.net/buildroot \
	--depth 1 --branch $(version) build/root

setup-%:
	test -f $(PWD)/configs/$*_defconfig
	BR2_EXTERNAL=$(PWD) make -C build/root \
	O=$(build_root) \
	$*_defconfig


configure-%:
	TERM=linux \
	make -C $(build_root) menuconfig

save-%:
	make -C $(build_root) savedefconfig

configure-linux-%:
	TERM=linux \
	make -C $(build_root) linux-menuconfig

save-linux-%:
	make -C $(build_root) linux-update-defconfig


build-%:
	make -C $(build_root) $(jobs)

clean-%:
	make -C $(build_root) clean

dist-clean-%:
	make -C $(build_root) distclean


temp:
	mkdir -p temp

fetch-%: temp
	scp $(remote)/build/$*/images/system.fw temp/


pull-diff:
	rsync --dry-run $(sync_args) \
	$(remote)/ \
	$(PWD)

pull:
	rsync $(sync_args) \
	$(remote)/ \
	$(PWD)

push-diff:
	rsync --dry-run --delete $(sync_args) \
	$(PWD)/ \
	$(remote)

push:
	rsync --delete $(sync_args) \
	$(PWD)/ \
	$(remote)


flash:
	test -f temp/system.fw
	fwup temp/system.fw

update:
	test -f temp/system.fw
	cat temp/system.fw | ssh -s $(node) update
