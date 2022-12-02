#include <stdio.h> //including the directives of stdio.h

typedef long long int INT;        // INT is used as alternative name of long long int
extern long long int fun4(INT N); //“extern” keyword is used to extend the visibility of function or variable

int main(void)
{
    INT N; // declaring variable N

    scanf("%lld", &N); // taking input from the user

    INT ans = fun4(N);//calling fun4 and storing the result into ans
    if (ans == 1)
        printf("TRUE\n");//printing TRUE if ans=1
    else if (ans == -1)
        printf("FALSE\n");//printing FALSE if ans=-1
}