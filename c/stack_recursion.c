#include<stdio.h>
#include<stdlib.h>

//汉诺塔，每次挪动必须保证大的在下小的在上，从a挪到b
void shift(char a, char b, char c, int n)
{
	if(n<1)
	{
		printf("你个憨批，输错了");

	}
	if(n==1)
	{
		printf("%c->%c\n",a,c);
	}
	else 
	{
		shift(a,c,b,n-1);		
		printf("%c->%c\n",a,c);
		shift(b,a,c,n-1);
	}
}

//爬楼梯，每次只能爬一格或者爬两格，爬n阶楼梯有多少中爬法
int clam(int n)  
{
	if(n<1)
	{
		printf("你个憨批，输错了");
		return 0;
	}
	if(n==1)
	{
		return 1;
	}
	else if(n==2)
	{
		return 2;
	}
	else
	{
		return clam(n-1) + clam(n-2);
	}
}
//斐波那契数列
int rabbit(int n)
{
	if(n<1)
	{
		printf("你个憨批，输错了");
		return 0;
	}
	else if(n==1 || n==2)
	{
		return 1;
	}
	else 
	{
		return rabbit(n-1) + rabbit(n-2);
	}
}


void main()
{
	shift('A','B','C',3);
	int x = clam(5);
	printf("%d\n",x);
	int y = rabbit(5);
	printf("%d\n",y);
}