#include <stdio.h>
typedef long long int INT;
extern INT parity(INT N);

int main(void)
{
    INT M;
    scanf("%lld", &M);
    // printf("%lld", sumfact(N));
    INT x = parity(M);
    if (x)
    {
        printf("TRUE\n");
    }
    else
    {
        printf("FALSE\n");
    }
}