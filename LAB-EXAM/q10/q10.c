#include <stdio.h>
typedef long long int INT;
extern INT bubblesort(INT* N, INT M);

int main(void)
{
    INT N;
    scanf("%lld",&N);
    INT A[N];
    for(int i=0;i<N;i++)
    {
        scanf("%lld",&A[i]);
    }
    // printf("%lld", sumfact(N));
    bubblesort(&A[0], N);

    for(int i=0;i<N;i++)
    {
        printf("%lld ",A[i]);
    }
     printf("\n");
}
