#include <stdio.h>//including the directives of stdio.h
typedef long long int INT;//INT is used as alternative name of long long int
extern long long int fun2(INT N,INT Y);//“extern” keyword is used to extend the visibility of function or variable

int main(void)
{
    INT N;//declaring a variables N
    scanf("%lld",&N);//taking inputs from the user
    printf("%lld\n",fun2(N,0));//printing the value of (fun2(N,0)) mod (13) as per specified format
}