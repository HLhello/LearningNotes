#include<stdio.h>
#include<stdlib.h>
#include<io.h>
#include<math.h>
#include<time.h>

#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0

/* 
 *	ADT 栈（stack）
 *  Data
 *  	同线性表。元素具有相同的类型，相邻元素具有前驱和后继的关系
 *  Operation
 *     	InitStack(*s):初始化操作，建立一个空栈
 *     	DestoryStack(*s):若栈存在，则销毁他
 *     	ClearStack(*s):将栈清空
 *     	StackEmpty(s):若栈为空，返回true，否则返回false
 *     	GetTop(s,*e):若栈存在且非空，用e返回s的栈顶元素
 *     	Push(*s,e):若栈存在，且非空，插入新元素e到栈中并成为栈顶元素
 *     	Pop(*s,*e):删除栈s中栈定的元素，并用e返回其值
 *     	StackLength(s):返回栈s的个数
 *  endADT
 */
#define MAXSIZE 20 // 存储空间初始分配量
typedef int Status; 
typedef int SElemType; //SElemType类型根据实际情况而定，这里假设为int 


//两栈共享空间结构
typedef struct
{
	SElemType data[MAXSIZE];
	int top1;
	int top2;
}DualSqStack;
enum stacknum {stack_0,stack_max};
typedef enum stacknum StackNum;
/*
//尝试使用枚举型变量来传入要压入那个栈中
Status testenum(enum stacknum stack_num)
{
	if(stack_num == stack_0)
	{
		printf("suprise!");
	}
}
void main()
{
	StackNum stack_num=stack_0;
	if(stack_num == stack_0)
	{
		printf("suprise!");
	}
	testenum(stack_num);
}
*/

//初始化化一个共享栈
Status InitDualStack(DualSqStack *S)
{
	S->top1 = -1;
	S->top2 = MAXSIZE;
	return OK;
}
/* 将一个元素压入栈中
 * 操作条件：存在一个空栈或者存在未满的栈，要选择压入哪一个栈中
 * 操作结果：成功
 */
Status PushDual(DualSqStack *S, SElemType e, StackNum stackx)
{
	if(S->top1+1 == S->top2)
	{
		return ERROR;
	}
	if(stackx == stack_0)
	{
		S->top1++;
		S->data[S->top1] = e;
	}
	else if(stackx == stack_max)
	{
		S->top2--;
		S->data[S->top2] = e;
	}
	return OK;
}
/* 将一个元素弹出
 * 操作条件：存在一个存在元素的栈，要选择弹出哪一个栈
 * 操作结果：成功
 */
Status PopDual(DualSqStack *S, SElemType *e, StackNum stackx)
{
	if(stackx == stack_0)
	{
		if(S->top1==-1)
		{
			return ERROR;
		}
		else
		{
			*e = S->data[S->top1];
			S->top1--;
			return OK;
		}
	}
	else
	{
		if(S->top2==MAXSIZE)
		{
			return ERROR;
		}
		else
		{
			*e = S->data[S->top2];
			S->top2++;
			return OK;
		}
	}
}
 
 
/*
//测试了初始化函数和压入元素的函数
void main()
{
	int init_x,push_x pop_x;
	SElemType e;
	StackNum num = stack_0;
	DualSqStack Ds;
	init_x = InitDualStack(&Ds);
	printf("init_x = %d\nDs.top1 = %d,Ds.top2 = %d\n",init_x,Ds.top1,Ds.top2);
	push_x = PushDual(&Ds,3,num);
	printf("push_x = %d\nDs.top1 = %d,Ds.top2 = %d\n",push_x,Ds.top1,Ds.top2);
	pop_x = PopDual(&Ds,&e,num);
	printf("e = %d\npop_x = %d\nDs.top1 = %d,Ds.top2 = %d\n",e,push_x,Ds.top1,Ds.top2);
}
*/



















