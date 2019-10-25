#include<stdio.h>
#include<stdlib.h>
#include<io.h>
#include<math.h>
#include<time.h>

#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0

#define MAXSIZE 20 // 存储空间初始分配量
typedef int Status; 

typedef struct calcnum
{
	int num[MAXSIZE];
	int top;
}calcnum;

typedef struct calcsym
{
	char sym[MAXSIZE];
	int top;
}calcsym;

Status pushnum(calcnum *calc_num, int numcalc)
{
	if(calc_num->top==MAXSIZE-1)
	{
		return ERROR;
	}
	else 
	{
		calc_num->top++;
		calc_num->num[top] = numcalc;
	}
	return OK;
}
Status popnum(calcnum *calc_num, int *numcalc)
{
	if(calc_num->top==-1)
	{
		return ERROR;
	}
	else 
	{
		*numcalc = calc_num[top]
		calc_num->top--;
	}
	return OK;
}
Status pushsym(calcsym *calc_sym, char symcalc)
{
	if(calc_sym->top==MAXSIZE-1)
	{
		return ERROR;
	}
	else 
	{
		calc_sym->top++;
		calc_sym->sym[top] = symcalc;
	}
	return OK;
}
Status pushsym(calcnum *calc_sym, int *symcalc)
{
	if(calc_sym->top==-1)
	{
		return ERROR;
	}
	else 
	{
		*symcalc = calc_sym[top]
		calc_sym->top--;
	}
	return OK;
}


void main()
{
	int num;
	char c;
	
	scanf("%d",&num);
	scanf("%c",&c);
	printf("%d",num);
	printf("%c",c);
}