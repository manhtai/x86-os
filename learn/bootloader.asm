; bootloader.asm
;
; Compile
;     nasm -f bin bootloader.asm -o bootloader
; Make a floppy disk
;     dd if=/dev/zero of=disk.img bs=512 count=2880
; Write to 1st sector
;     dd conv=notrunc if=bootloader of=disk.img bs=512 count=1 seek=0
; Start
;     qemu-system-i386 -machine q35 -drive format=raw,file=disk.img,if=floppy -gdb tcp::26000 -S
; gdb from another terminal:
;     gdb> set architecture i8086
;     gdb> target remote localhost:26000
;     gdb> c

org 0x7c00
bits 16
start: jmp boot

; constant and variable definitions
msg db "Welcome to My Operating System!", 0ah, 0dh, 0h

boot:
  cli ; no interrupts
  cld ; all that we need to init
  hlt ; halt the system

; Size must be 512 bytes. Clear the rest of the bytes with 0

times 510 - ($-$$) db 0
dw 0xAA55 ; Boot Signiture
