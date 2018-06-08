/* hello.c
 *
 * gcc -m32 -g hello.c -o hello
 * objdump -S hello | less
 * objdump -M intel -D hello | less
 */

#include <stdio.h>


int main(int argc, char *argv[]) {
    printf("Hello World!\n");
    return 0;
}
