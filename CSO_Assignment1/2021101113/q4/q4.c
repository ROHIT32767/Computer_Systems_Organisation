#include <stdio.h>//including the directives of stdio.h

typedef long long int INT;//INT is used as alternative name of long long int
extern long long int fun4(INT N);   //“extern” keyword is used to extend the visibility of function or variable
extern long long int fun5(INT N);   //“extern” keyword is used to extend the visibility of function or variable

int main(void)
{
    INT N;// declaring variable N

    scanf("%lld",&N);// taking input from the user

    INT M=fun5(N);//calling fun5 and storing the result into M

    printf("%lld\n",M);//printing the value of M as per specified format

}
