; jmp.asm
;
; nasm -f bin jmp.asm -o jmp
; hexdump jmp
;
; Output:
; 0000000 eb fe eb 02 eb fa e9 2b 12
; 0000009

main:
  jmp main
  jmp main2
  jmp main
main2:
  jmp 0x1234
