#include <stdio.h>
typedef long long int INT;
extern INT partition(INT* N, INT M,INT H);

void quicksort1(INT* A,INT low,INT high)
{
     if((low>=high)||(low<0))
     {
return;
     }
     INT p=partition(A,low,high);
     quicksort1(A,low,p-1);
     quicksort1(A,p+1,high);
}

int main(void)
{
    INT N;
    scanf("%lld",&N);
    INT A[N];
    for(INT i=0;i<N;i++)
    {
        scanf("%lld",&A[i]);
    }
    // printf("%lld", sumfact(N));
    quicksort1(A,0,N-1);

    for(INT i=0;i<N;i++)
    {
        printf("%lld ",A[i]);
    }
    printf("\n");
}
