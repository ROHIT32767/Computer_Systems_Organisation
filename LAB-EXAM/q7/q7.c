#include <stdio.h>
typedef long long int INT;
extern INT binarySearch(INT* N, INT M,INT X);

int main(void)
{
    INT N;
    scanf("%lld",&N);
    INT A[N];
    for(int i=0;i<N;i++)
    {
        scanf("%lld",&A[i]);
    }
    INT key;
    scanf("%lld",&key);
    // printf("%lld", sumfact(N));
    INT x=binarySearch(&A[0], N,key);

     printf("%lld",x);
    
     printf("\n");
}
