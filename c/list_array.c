#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<time.h>
#include<io.h>

#define OK 1
#define ERROR 0
#define TURE 1
#define FALSE 0

#define MAXSIZE 20

//typedef 将C语言中的类型定义换个名字,不会的可以看看typedef的使用
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

typedef struct 					//定义线性表的顺序存储的结构代码
{								//三要素：线性表的起始位置data,
	ElemType data[MAXSIZE];		//        线性表的最大存储容量MAXSIZE
	int Length;					//        线性表的当前长度
}SqList;						//SqList 该类型数据的名字

/*
//test code envirmentment
Status visit(ElemType c)  
{
	printf("%d\n",c);
	return OK;
}
void main()
{
	ElemType x;
	x = visit(5);
	printf("%d",x);
}
*/

//将线性表中第i个元素取出来，并复制给一个整数指针e
Status GetElem(SqList L, int i, ElemType *e)//为啥返回的值要使用指整呢？
{
	if(L.Length==0 || i<1 || i>L.Length)
	{
		return ERROR;
	}
	*e = L.data[i-1];
	return OK;
}

/*
//取出定义结构体的的第5个数
void main()
{
	int s;
	ElemType e;
	SqList L = {{1,2,3,4,5,6,7,8,9,10}, 10}; // 结构体的赋值方式
	
	s = GetElem(L, 5, &e); // 函数参数的传递
	printf("L.data[5] = %d\nStaus = %d\n", e,s);
}
*/

//在线性表L中的第i个位置上插入e
Status ListInsert(SqList *L, int i, ElemType e)
{
	int k;
	if(L->Length==MAXSIZE)
	{
		return ERROR;
	}
	if(i<1 || (i-1)>L->Length)
	{
		return ERROR;
	}	
	else if(i<=L->Length)
	{
		for(k=L->Length-1;k>=i-1;k--)
		{
			L->data[k+1] = L->data[k];
		}		
	}
	L->data[i-1] = e;
	L->Length++;
	return OK;
}

/*
//测试插入函数，在L->data[5]中插入1
void main()
{
	int s;
	ElemType e = 100;
	
	SqList L = {{1,2,3,4,5,6,7,8,9,10}, 10};
	
	s = ListInsert(&L, 5, e); // 注意传递参数的方式
	printf("L.Length = %d\n", L.Length);
	for(int i=0;i<L.Length;i++)
	{
		printf("%-5d ",L.data[i]);
	}
	
	printf("\nStatus = %d",s);
}
*/


/*	从线性表中删除一个已经存在的元素
 *	初始条件：顺序线性表L已经存在
 *	操作结果：删除L的第i个数据元素，并用e返回其值，L的长度减1
 */
Status ListDelete(SqList *L, int i, ElemType *e)
{
	int k;
	if(L->Length==0 || i<1 || i>L->Length)
	{
		return ERROR;
	}
	else
	{
		*e = L->data[i-1];
		L->Length = L->Length - 1;
		
		for(k=i;k<=L->Length;k++)
		{
			L->data[k-1] = L->data[k];
		}		
	}
	
	return OK;
}

//测试删除指定位置数据的函数
void main()
{
	int s;
	ElemType del_data;
	SqList L = {{1,2,3,4,5,6,7,8,9,10}, 10};
	s = ListDelete(&L, 5, &del_data);
	
	printf("del_data = %d, L.Length= %d\n", del_data,L.Length);
	
	for(int i=0;i<L.Length;i++)
	{
		printf("%-5d ",L.data[i]);
	}
	printf("\nStatus = %d", s);
}



















