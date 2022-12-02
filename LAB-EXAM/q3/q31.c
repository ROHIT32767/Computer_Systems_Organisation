#include <stdio.h>
typedef long long int INT;
extern INT sum(INT* A,INT M,INT N);

int main(void)
{
    INT M, N;
    scanf("%lld %lld", &M,&N);
    INT A[M][N];
    // printf("%lld", sumfact(N));
    for(int i=0;i<M;i++)
    {
        for(int j=0;j<N;j++)
        {
            scanf("%lld",&A[i][j]);
        }
    }

    INT x = sum(&A[0][0],M,N);

    printf("%lld\n", x);
}