#include <stdio.h>
typedef long long int INT;
extern INT prime(INT N);
extern INT sum(INT N, INT M);

int main(void)
{
    INT M, N;
    scanf("%lld %lld", &M,&N);
    // printf("%lld", sumfact(N));
    INT x = sum(M,N);

    printf("%lld\n", x);
}