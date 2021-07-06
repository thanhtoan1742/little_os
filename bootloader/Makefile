src := *.s

all: bootloader.bin

bootloader.bin: $(src)
	nasm -f bin bootsector.s -o $@

.PHONY: clean
clean:
	rm -rf *.bin
