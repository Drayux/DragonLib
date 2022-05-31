#include <stdio.h>
#include <stdlib.h>

extern int add(int a, int b);
extern int subtract(int a, int b);

int main(int argc, char** argv) {
	int x = 3;
	int y = 5;

	printf("Hello world\n");
	printf("Add result: %d\n", add(x, y));
	printf("Sub result: %d\n", subtract(x, y));

	return 0;
}
