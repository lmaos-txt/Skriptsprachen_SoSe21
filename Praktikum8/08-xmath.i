%module XMath
%{
    #include <math.h>
    double sin_int( double x0, double x1, int n2 );
%}
extern double scalbn(double, int);
extern double log1p(double);
extern double sin_int( double x0, double x1, int n2 );