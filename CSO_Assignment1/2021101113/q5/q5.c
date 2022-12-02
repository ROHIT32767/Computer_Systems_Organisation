#include <stdio.h>//including the directives of stdio.h


typedef long long int INT;//INT is used as alternative name of long long int
 
extern long long int fun6(INT N,INT K);  //“extern” keyword is used to extend the visibility of function or variable

int main(void)
{
    INT N;// declaring variable N

    scanf("%lld",&N);// taking input from the user
    INT LONG = 9223372036854775807;//LONG=LONG_MAX
    INT M=fun6(N,LONG);//calling fun6 and storing the result into M

    printf("%lld\n",M);//printing the value of M as per specified format

}