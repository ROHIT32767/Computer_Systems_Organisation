#include <stdio.h>
typedef long long int INT;
extern long long int fun2(INT N);

int main(void)
{
    INT N;
    scanf("%lld",&N);
    printf("%lld\n",fun2(N));


}