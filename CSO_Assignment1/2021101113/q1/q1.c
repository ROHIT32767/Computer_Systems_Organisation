#include <stdio.h>//including the directives of stdio.h

typedef long long int INT;//INT is used as alternative name of long long int

extern long long int fun1(INT M,INT N);//“extern” keyword is used to extend the visibility of function or variable
extern long long int fun2(INT M,INT N);//“extern” keyword is used to extend the visibility of function or variable

int main(void)
{
    INT M,N;//declaring 2 variables M and N

    scanf("%lld %lld",&M,&N);//taking inputs from the user

    
   // fun0(M,N);
    INT r=fun1(M,N);//calling fun1 and storing the result into r(remainder)
    INT q=fun2(M,N);//calling fun2 and storing the result into q(quotient)

    printf("%lld %lld\n",q,r);//printing the values of quotient and remainder as per specified format

}

