#include <stdio.h>
typedef long long int INT;
extern INT firstN(INT N, INT M);

int main(void)
{
    INT M, N;
    scanf("%lld %lld", &M, &N);
    // printf("%lld", sumfact(N));
    INT x = firstN(M, N);

    printf("%lld\n", x);
}
