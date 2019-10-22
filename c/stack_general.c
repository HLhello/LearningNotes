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


//顺序结构栈
typedef struct
{
	SElemType data[MAXSIZE];
	int top;
}SqStack;

/* 初始化一个空栈
 * 操作条件：定义一个栈并将地址传入函数中
 * 操作结果：初始化成功
 */
Status InitStack(SqStack *S)
{
	for(int i=0;i<MAXSIZE;i++)
	{
		S->data[i] = 0;
	}
	S->top = -1;
	return OK;
}
/* 往栈中压入元素
 * 操作条件：存在一个或者初始化一个空栈
 * 操作结果：插入成功
 */
Status Push(SqStack *S, SElemType e)
{
	if(S->top == MAXSIZE-1)
	{
		return ERROR;
	}
	S->top++;
	S->data[S->top] = e;
	return OK;
}
/*
//测试向栈中压入元素
void main()
{
	Status init_x,push_x;
	SqStack S;
	init_x = InitStack(&S);
	printf("S.top = %d\n",S.top);
	push_x = Push(&S, 5);
	printf("S.top = %d\n",S.top);
	printf("S.data[0] = %d\n",S.data[0]);
	printf("init_x = %d\npush_x = %d\n",init_x,push_x);
}
*/
/* 从栈中弹出栈顶元素
 * 操作条件：存在一个有元素的栈，并用e返回弹出的值
 * 操作结果：弹出成功
 */
Status Pop(SqStack *S, SElemType *e)
{
	if(S->top == -1)
	{
		return ERROR;
	}
	*e = S->data[S->top];
	S->top--;
	return OK;
}

/*
//测试弹出函数
void main()
{
	SElemType se;
	int init_x, push_x, pop_x;
	SqStack S;
	init_x = InitStack(&S);
	push_x = Push(&S, 5);
	pop_x = Pop(&S,&se);
	printf("init_x = %d\npush_x = %d\npop_x = %d\n",init_x,push_x,pop_x);
	printf("S.top = %d\n",S.top);
	printf("the pop SElemType is %d\n",se);
}
*/
/* 若栈存在返回栈顶元素
 * 操作条件：存在一个有元素的栈，并用e返回栈顶的值
 * 操作结果：返回值正确
 */
Status GetTop(SqStack *S, SElemType *e)
{
	if(S->top == -1)
	{
		return ERROR;
	}
	*e = S->data[S->top];
	return OK;
}

/*
//测试返回栈顶的元素
void main()
{
	SElemType se,top_se;
	int init_x, push_x, pop_x,top_x;
	SqStack S;
	init_x = InitStack(&S);
	for(int i=0;i<10;i++)
	{
		push_x = Push(&S, i);
	}
	pop_x = Pop(&S,&se);
	printf("the pop SElemType is %d\n",se);
	printf("init_x = %d\npush_x = %d\npop_x = %d\n",init_x,push_x,pop_x);
	printf("S.top = %d\n",S.top);
	top_x = GetTop(&S, &top_se);
	printf("top_x = %d\n",top_x);
	printf("the top SElemType is %d\n",top_se);
}
*/












































