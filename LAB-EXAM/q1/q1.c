#include <stdio.h>
typedef long long int INT;
extern INT switchcase(INT N,INT M,INT S);

int main(void)
{
    INT M,N,S;
    scanf("%lld %lld %lld", &M,&N,&S);
    // printf("%lld", sumfact(N));
    INT x = switchcase(M,N,S);
    printf("%lld\n",x);
}