all: os

run: bootloader
	qemu-system-x86_64 \
	-drive format=raw,file=bin/bootloader.bin \
	-monitor stdio \
	-d cpu_reset

os: bootloader kernel
	dd if=/dev/zero of=bin/os.bin bs=512 count=30000
	dd if=bin/bootloader.bin of=bin/os.bin conv=notrunc seek=0 bs=512 count=1
	dd if=bin/kernel.elf of=bin/os.bin conv=notrunc seek=1 bs=512 count=1

bootloader:
	$(MAKE) --directory=bootloader all
	cp bootloader/bootloader.bin bin/

kernel:
	$(MAKE) --directory=kernel all
	cp kernel/kernel.elf bin/

.PHONY: os bootloader kernel clean

clean:
	rm -rf bin/*
	$(MAKE) --directory=bootloader clean
	$(MAKE) --directory=kernel clean

