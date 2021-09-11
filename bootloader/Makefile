src := *.asm

all: bootloader.bin

bootloader.bin: $(src)
	nasm -f bin bootsector.asm -o $@

.PHONY: clean
clean:
	rm -rf *.bin
