#include <upc.h>
#include <stdio.h>

int main(int argc, char **argv){
	printf("Thread %d of %d: Hello World\n", MYTHREAD, THREADS);

	return 0;
}

