#include <stdio.h>//including the directives of stdio.h

typedef long long int INT;//INT is used as alternative name of long long int
extern long long int fun3(INT M,INT N);  //“extern” keyword is used to extend the visibility of function or variable
 
int main(void)
{
    INT M,N;//declaring 2 variables M and N

    scanf("%lld %lld",&M,&N);//taking inputs from the user

    INT ans=fun3(M,N);//calling fun3 and storing the result into ans

    printf("%lld\n",ans);//printing the value of ans as per specified format

    
}