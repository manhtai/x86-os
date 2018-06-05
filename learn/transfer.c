/* transfer.c
 *
 * gcc -g transfer.c -o transfer
 * gobjdump --no-show-raw-insn -M intel -S -D transfer
*/

#include <stdint.h>
int32_t i = 0x12345678;

int main(int argc, char *argv[]) {
    int j = i;
    int k = 0xabcdef;
    return 0;
}
