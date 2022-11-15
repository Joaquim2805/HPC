#include <upc_relaxed.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define TOTALSIZE 16

shared double x[TOTALSIZE*THREADS];
shared double x_new[TOTALSIZE*THREADS];
shared double b[TOTALSIZE*THREADS];

void init();

int main(int argc, char **argv){
    int j;

    init();
    upc_barrier;

    // ==> setup j to point to the first element so that the current thread should
    // progress (in respect to its affinity)
    
	j = *x_new ;

	

    // ==> add a for loop which goes only through the elements in the x_new array
    // with affinity to the current THREAD

    for( j=MYTHREAD; j<TOTALSIZE*THREADS-1; j+=THREADS )
        x_new[j] = 0.5*( x[j-1] + x[j+1] + b[j] );

    upc_barrier;

    if( MYTHREAD == 0 ){
        printf("   b   |    x   | x_new\n");
        printf("=============================\n");

        for( j=0; j<TOTALSIZE*THREADS; j++ )
            printf("%1.4f | %1.4f | %1.4f \n", b[j], x[j], x_new[j]);
    }

    return 0;
}

void init(){
    int i;

    if( MYTHREAD == 0 ){
        srand(time(NULL));

        for( i=0 ; i<TOTALSIZE*THREADS; i++ ){
            b[i] = (double)rand() / RAND_MAX;
            x[i] = (double)rand() / RAND_MAX;
        }
    }
}

