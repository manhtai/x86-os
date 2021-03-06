C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
# Nice syntax for file extension replacement
OBJ = ${C_SOURCES:.c=.o}

# Change this if your cross-compiler is somewhere else
CC = i686-elf-gcc
LD = i686-elf-ld
GDB = gdb

# -g: Use debugging symbols in gcc
CFLAGS = -g

# First rule is run by default
os-image.bin: boot/bootsect.bin kernel.bin
	cat $^ > os-image.bin

# '--oformat binary' deletes all symbols as a collateral, so we don't need
# to 'strip' them manually on this case
kernel.bin: boot/kernel_entry.o ${OBJ}
	${LD} -o $@ -Ttext 0x1000 --entry main $^ --oformat binary

# Used for debugging purposes
kernel.elf: boot/kernel_entry.o ${OBJ}
	${LD} -o $@ -Ttext 0x1000 --entry main $^

run: os-image.bin
	qemu-system-i386 -drive format=raw,file=os-image.bin,if=floppy

# Open the connection to qemu and load our kernel-object file with symbols
debug: os-image.bin
	qemu-system-i386 -drive format=raw,file=os-image.bin,if=floppy -gdb tcp::26000 -S

gdb:
	${GDB} -ex "set architecture i8086" -ex "target remote localhost:26000" -ex "symbol-file kernel.elf"

# Generic rules for wildcards
# To make an object, always compile from its .c
%.o: %.c
	${CC} ${CFLAGS} -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

clean:
	rm -rf *.bin *.dis *.o os-image.bin *.elf
	rm -rf kernel/*.o boot/*.bin drivers/*.o boot/*.o
