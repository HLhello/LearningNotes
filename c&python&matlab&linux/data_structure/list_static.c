#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<time.h>
#include<io.h>

#define OK 1
#define ERROR 0
#define TURE 1
#define FALSE 0

typedef int Status; 			//Status 定义函数的类型，该类型的函数的放回值是整形的状态变量
typedef int ElemType; 			//希望使用什么类型的数据结构可以将int替换成希望的类型 
/*
ADT 线性表（List）
Data
线性表的数据对象集合为{a1,a2,...,an},每个元素的类型均为datetype，其中，除了第一个元素，每一个元素都有且只有一个直接前驱元素，除了最后一个元素，每一个元素都有且只有一个直接后继元素，数据之间的关系是一对一的关系
Operation
InitList（*L）：初始化操作，建立一个空的线性表L
ListEmpty（L）：若线性表为空，返回true，否则返回false
ClearList（*L）：将线性表清空
GetElem（L,i,*e）：将线性表L中第i个元素返回给e
LocateElem（L,e）：在线性表L中查找与给定值e相等的元素，如果查找成功，返回
ListInsert（*L，i，e）：
ListDelete（*L,i,*e）：
ListLength（L）：
endDat
*/

#define MAXSIZE 1000

typedef struct
{
	ElemType data;
	int cur;
}Component, ListStatic[MAXSIZE];


//查看链上的指定元素
Status visit(ElemType e)
{
	printf("%d",e);
	return OK;
}
//按照索引查看整个链上的元素
Status ListTraverse(ListStatic L)
{
    int j=0;
    int i=L[MAXSIZE-1].cur;
    while(i)
    {
		visit(L[i].data);
		i=L[i].cur;
		j++;
    }
    return j;
    printf("\n");
    return OK;
}

/*	初始化一个静态链表
 *	初始条件：定义了一个结构体数组
 *	操作结果：成功初始化数据与cur
 */
Status InitList(ListStatic space)
{
	int i;
	for(i=0;i<MAXSIZE-1;i++)
	{
		space[i].cur = i+1;
	}
	space[MAXSIZE-1].cur = 0;
	return OK;
}
/*
//测试初始化函数
void main()
{
	int s;
	ListStatic Ls;
	s = InitList(Ls);
	printf("Status = %d\n",s);
}
*/

/*	查询应该静态链表中空的节点
 *	初始条件：定义了一个结构体数组
 *	操作结果：返回空节点的下标
 *	存在问题：未测试 TODO
 */
int MallocListStatic(ListStatic space)
{
	int i = space[0].cur;
	if(space[0].cur)
	{
		space[0].cur = space[i].cur;
	}
	
	return i;
}
/*	静态链表的超度
 *	初始条件：定义了一个结构体数组
 *	操作结果：返回链表的长度
 *	存在问题：未测试 TODO
 */
int ListLength(ListStatic L)
{
	int j=0;
	int i = L[MAXSIZE-1].cur;
	while(i)
	{
		i = L[i].cur;
		j++;
	}
	return j;
}
/*
//测试长度函数
void main()
{
	int Len,s;
	ListStatic L;
	s = InitList(L);
	Len = ListLength(L);
	printf("the length of L is %d\n",Len);
	
}
*/

/*	静态链表中的插入操作
 *	初始条件：定义了一个结构体数组
 *	操作结果：在第i个位置插入e插入成功
 *	存在问题：
 */
Status ListInsert(ListStatic L, int i, ElemType e)
{
	int k,j,m;
	k = MAXSIZE-1;
	if(i<1 || i>ListLength(L)+1)  //插入位置在现有的位置之内才能继续
	{
		return ERROR;
	}
	j = MallocListStatic(L);	//找出备用链的第一个
	if(j)
	{
		L[j].data = e;
		for(m=1;m<=i-1;m++)
		{
			k = L[k].cur;
		}
		L[j].cur = L[k].cur;
		L[k].cur = j;
		return OK;
	}
	return ERROR;
}


/*	静态链表中的删除操作
 *	初始条件：定义了一个结构体数组
 *	操作结果：删除第i个位置的元素
 *	存在问题：
 */
Status FreeStaticNode(ListStatic L, int k)
{
	L[k].cur = L[0].cur;
	L[0].cur = k;
	return OK;
}
Status ListDelete(ListStatic L, int i)
{
	int j,k;
	if(i<1 || i>ListLength(L)+1)  //插入位置在现有的位置之内才能继续
	{
		return ERROR;
	}
	k = MAXSIZE - 1;
	for(j=1;j<=i-1;j++)
	{
		k = L[k].cur;
	}
	j = L[k].cur;
	L[k].cur = L[j].cur;
	FreeStaticNode(L,j);
	return OK;
}

/*
//
void main()
{
	Status Init_s,Inserts,isdel;
	Status Insert_s[5];
	int Len;
	ListStatic L;
	Init_s = InitList(L);
	for(int i=1;i<5;i++)
	{
		Insert_s[i] = ListInsert(L,i,i);
	}
	Len = ListLength(L);
	printf("Init_s = %d\n",Init_s);
	for(int i=0;i<5;i++)
	{
		printf("%-2d",Insert_s[i]);
	}
	
	printf("\nthe length of L is %d\n",Len);
	for(int i=0;i<Len;i++)
	{
		printf("Ls.data = %d, Ls.cur = %d\n",L[i+1].data,L[i+1].cur);
	}
	ListTraverse(L);
	printf("\n");
	Inserts = ListInsert(L,3,9);
	printf("Inserts = %d\n",Inserts);
	Len = ListLength(L);
	printf("the length of L is %d\n",Len);
	for(int i=0;i<Len;i++)
	{
		printf("Ls.data = %d,Ls.cur = %d\n",L[i+1].data,L[i+1].cur);
	}
	ListTraverse(L);
	printf("\n");
	isdel = ListDelete(L,1);
	ListTraverse(L);  //
	printf("\n");
}
*/




























