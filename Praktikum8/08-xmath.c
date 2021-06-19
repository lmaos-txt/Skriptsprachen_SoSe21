#include <math.h>
#include <stdio.h>
double sin_int( double x0, double x1, int n2 ){
    double delta = (x1-x0)/(n2*2);
    double front = 0, mid = 0, back = 0;
    for (int i = 0; i <= 2*n2; i++)
    {
        if((i == 0) || (i == 2*n2)){
            front += sin(x0+i*delta);
        }
        if((i == 0) && (i == 2*n2)){
            back += sin(x0+i*delta);
        }
        if(i%2 == 1){
            mid += sin(x0+i*delta);
        }
    }
    return (delta/3)*(front+4*mid+2*back);
}
