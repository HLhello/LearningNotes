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


//存储数据的节点
typedef struct StackNode
{
	SElemType data;
	struct StackNode *next;
}StackNode, *StackLinkPtr;
//存储栈顶元素的节点，并且反映栈的状态
typedef struct StackLink
{
	StackLinkPtr top;
	int count;
}StackLink;
//实际上StackNode StackLink 是一样的，都是一个整数，一个StackNode类型的指针
//链栈就是StackLink，StackNode是数据的链式存储


/* 向栈中压入一个元素
 * 操作条件：已经存在一个链栈，向链栈中压入一个元素
 * 操作结果：
 */
Status Push(StackLink *S, SElemType e)
{
	StackLinkPtr sl = (StackLinkPtr)malloc(sizeof(StackNode));
	sl->data = e;
	sl->next = S->top;
	S->top = sl;
	S->count++;
	return OK;
}

/* 从栈中弹出一个元素
 * 操作条件：从一个非空链栈中弹出一个元素，并使用e返回弹出的元素
 * 操作结果：弹出成功
 */
Status Pop(StackLink *S, SElemType *e)
{
	if(S->count==-1)
	{
		return ERROR;
	}
	StackLinkPtr p = (StackLinkPtr)malloc(sizeof(StackNode));
	p = S->top;
	*e = S->top->data;
	S->top = S->top->next;
	S->count--;
	free(p);//记得要将节点释放
	return OK;
}

void main()
{
	StackLink S;
	S.top = NULL;
	S.count = -1;
	Status push_x;
	push_x = Push(&S,5);
	push_x = Push(&S,6);
	push_x = Push(&S,7);
	printf("%d\n",push_x);
	printf("%d\n",(S.top)->data);
	SElemType e;
	Pop(&S,&e);
	printf("%d\n",(S.top)->data);
	push_x = Push(&S,100);
	printf("%d\n",push_x);
	Pop(&S,&e);
	printf("%d\n",e);
	push_x = Push(&S,100);
	Pop(&S,&e);
	printf("count%d\n",S.count);
	Pop(&S,&e);
	printf("%d\n",e);
}






































