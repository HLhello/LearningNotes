#include<stdio.h>
#include<stdlib.h>

void main()
{
	char a = 'a';
	printf("%p\n", &a);
	printf("%c\n", a);

	char * p = &a;
	printf("%d\n", sizeof(p));
	printf("%d\n", sizeof(*p));
	printf("%p\n", p);
	printf("%p\n", &p);
	printf("%c\n", *p);


	char * * double_p = &p;
	printf("%d\n", sizeof(double_p));
	printf("%d\n", sizeof(*double_p));
	printf("%d\n", sizeof(**double_p));
	printf("%p\n", double_p);
	printf("%p\n", *double_p);
	printf("%c\n", **double_p);

	system("pause");
}