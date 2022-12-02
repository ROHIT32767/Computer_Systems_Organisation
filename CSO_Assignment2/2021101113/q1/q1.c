#include <stdio.h>//including the directives of stdio.h
typedef long long int INT;//INT is used as alternative name of long long int
extern long long int fun1(INT N,INT* X,INT* Y);//“extern” keyword is used to extend the visibility of function or variable

int main(void)
{
    INT N;//declaring a variables N
    scanf("%lld",&N);//taking inputs from the user
    INT A[N],B[N];// declaring two arrays A,B
    for(INT i=0;i<N;i++)
    {
        scanf("%lld",&A[i]);//scanning elements of input array
    }
    fun1(N,A,B);// calling fun1
    for(INT i=0;i<N;i++)
    {
        printf("%lld ",B[i]);//printing values of output array
    }
    printf("\n");// printing new line

}