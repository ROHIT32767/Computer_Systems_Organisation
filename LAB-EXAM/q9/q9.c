#include <stdio.h>
typedef long long int INT;
extern INT factorial(INT N);
extern INT sumfact(INT N);

int main(void)
{
    INT N;
    scanf("%lld", &N);
    //printf("%lld", sumfact(N));
   INT  x =sumfact(N);
    if ( x== 1)
    {
        printf("TRUE\n");
    }
    else if(x==-1)
    {
        printf("FALSE\n");
    }
}