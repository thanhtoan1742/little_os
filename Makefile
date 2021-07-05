all: bootloader

run: bootloader
	qemu-system-x86_64 -drive format=raw,file=bin/bootloader.bin

bootloader:
	$(MAKE) --directory=bootloader all
	cp bootloader/bootloader.bin bin/

.PHONY: bootloader clean

clean:
	rm -rf bin/*
	$(MAKE) --directory=bootloader clean

