#include <stdio.h>
#include <time.h>

#define LGCS_A	5
#define LGCS_B	3
#define LGCS_M	32768
/* #define CHK_MSK	0x0004 */
/* #define CHK_MSK	0x0008 */
/* #define CHK_MSK	0x0010 */
/* #define CHK_MSK	0x0020 */
/* #define CHK_MSK	0x0040 */
#define CHK_MSK	0x0080

unsigned short lgcs_x;

void lgcs_seed(unsigned short x_0)
{
	lgcs_x = x_0;
}

unsigned short lgcs_rand(void)
{
	lgcs_x = ((LGCS_A * lgcs_x) + LGCS_B) & (LGCS_M - 1);
	return lgcs_x;
}

int main(void)
{
	unsigned short i, counter = 0;
	unsigned short rnd;
	lgcs_seed((unsigned short)time(NULL));
	for (i = 0; i < LGCS_M; i++) {
		rnd = lgcs_rand();
		/* printf("%d ", rnd); */
		if (rnd & CHK_MSK) {
			printf("zun ");
			counter++;
		} else {
			printf("doko ");
			if (counter >= 4) {
				printf("ki yo shi\n");
				break;
			}
			counter = 0;
		}
	}
	return 0;
}
