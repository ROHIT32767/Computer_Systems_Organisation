#include <stdio.h>
#include <stdlib.h>
typedef long long int INT;
extern void mult(INT M,INT N,INT P,INT* A,INT* B,INT* C);

int main(void)
{
    INT M, N, P;
    scanf("%lld %lld %lld", &M, &N, &P);
    INT A[M][N], B[N][P],C[M][P];
    
    // printf("%lld", sumfact(N));
    for (int i = 0; i < M; i++)
    {
        for (int j = 0; j < N; j++)
        {
            scanf("%lld", &A[i][j]);
        }
    }
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < P; j++)
        {
            scanf("%lld", &B[i][j]);
        }
    }
    mult(M,N,P,&A[0][0],&B[0][0],&C[0][0]);

    for (int i = 0; i < M; i++)
    {
        for (int j = 0; j < P; j++)
        {
            printf("%lld ",C[i][j]);
        }
        printf("\n");
    }
}