#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define TOTALSIZE 800

void init();

double x_new[TOTALSIZE];
double x[TOTALSIZE];
double b[TOTALSIZE];

int main(int argc, char **argv){
    int j;

    init();

    for( j=1; j<TOTALSIZE-1; j++ ){
        x_new[j] = 0.5 * ( x[j-1] + x[j+1] + b[j] );
    }

    printf("   b   |    x   | x_new\n");
    printf("=============================\n");

    for( j=0; j<TOTALSIZE; j++ )
        printf("%1.4f | %1.4f | %1.4f \n", b[j], x[j], x_new[j]);

    return 0;
}

void init(){
    int i;

    srand( time(NULL) );

    for( i=0; i<TOTALSIZE; i++ ){
        b[i] = (double)rand() / RAND_MAX;
        x[i] = (double)rand() / RAND_MAX;
    }
}

