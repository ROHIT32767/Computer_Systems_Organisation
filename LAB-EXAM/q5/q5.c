#include <stdio.h>
typedef long long int INT;
extern INT factorial(INT N);
extern INT firstfact(INT N);

int main(void)
{
    INT N;
    scanf("%lld", &N);
    //printf("%lld", sumfact(N));
   INT  x =firstfact(N);
    

    printf("%lld\n",x);
    
}