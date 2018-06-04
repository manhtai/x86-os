/* hello.c
 *
 * cc -s hello.c -o hello
 * objdump -S hello | less
 * objdump -x86-asm-syntax intel -D hello | less
 */

#include <stdio.h>

int main() {
    printf("hello world!");
    return 0;
}
