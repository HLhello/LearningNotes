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

//定义了一个单链表类型，可以使用Node创建节点
typedef struct Node
{
	ElemType data;
	struct Node *next;
}Node;

//定义了一个单链表类型的指针
typedef struct Node * LinkList;		//LinkList是什么，是一个类型，是什么类型，是指针类型


/*	取出第i个数据
 *	初始条件：顺序线性表已经存在，1 <= i <= LinkList(L)
 *	操作结果：用e返回L中第i个数据的值
 */
Status GetElem(LinkList L, int i, ElemType *e)
{
	int j = 1;
	LinkList p;
	p = L->next; //p = *L 这两句话一样么？

	while (p && j<i) //是不是也可以改写成do while？不行，因为dowhile是做了之后才判断的也就是说先挪指针在判断是否符合条件
	{
		p = p->next;
		++j;  		//先自加还是先引用？最好还是先搞清楚，不过这里是不是无所谓呀
	}
	if (!p || j>i) //其实改写的方法还挺多的，可以使用break来返回状态
	{
		return ERROR;
	}

	*e = p->data;

	return OK;
}

/*
//测试从线性链表中取值的函数
void main()
{
	int s;
	ElemType e;
	LinkList L;
	Node n1,n2,n3,n4,n5;
	n1.data = 1;
	n2.data = 2;
	n3.data = 3;
	n4.data = 4;
	n5.data = 5;
	n1.next = &n2;
	n2.next = &n3;
	n3.next = &n4;
	n4.next = &n5;
	n5.next = NULL;

	L->data = 0;
	L->next = &n1;

	s = GetElem(L, 2, &e);  //注意这里是如何传递结构体指针的，直接传递地址即可

	printf("Status = %d\nGetdata = %d\n",s,e);
}
*/

/*	在顺序性链表中插入值
 *	初始条件：顺序线性表已经存在，1 <= i <= LinkList(L)
 *	操作结果：在L中第i个节点位置之前插入行的数据元素e，L的长度加1
 *	问题：这个插入函数还是有问题，比对书上的代码就能知道问题的所在 TODO
 */
Status ListInsert(LinkList L, int i, ElemType e)
{
	int j = 1;
	LinkList p, s;
	p = L->next;

	while (p && j<i)
	{
		p = p->next;
		++j;
	}
	if (!p || j>i) //其实改写的方法还挺多的，可以使用break来返回状态
	{
		return ERROR;
	}

	s = (LinkList)malloc(sizeof(Node)); //为啥不创建一个节点呢，而要创建一个节点指针？
	s->data = e;
	s->next = p->next;
	p->next = s;

	return OK;
}
/*
//测试从线性链表中取值的函数
void main()
{
	int s;
	ElemType e = 6;
	LinkList L = (LinkList)malloc(sizeof(Node));
	
	Node n1, n2, n3, n4, n5;
	n1.data = 1;
	n2.data = 2;
	n3.data = 3;
	n4.data = 4;
	n5.data = 5;
	n1.next = &n2;
	n2.next = &n3;
	n3.next = &n4;
	n4.next = &n5;
	n5.next = NULL;

	L->data = 0;
	L->next = &n1;

	s = ListInsert(L, 2, e);  //注意这里是如何传递结构体指针的，直接传递地址即可
	LinkList p;// = (LinkList)malloc(sizeof(Node));
	p = L->next;
	for (int i = 1; i <= 6; i++)
	{
		printf("n[%d] = %d\n", i, p->data);
		p = p->next;
	}
	printf("Status = %d\n", s);
}
*/
/*	在顺序存储的链式结构中删除一个节点
 *	初始条件：顺序线性表已经存在，1 <= i <= LinkList(L)
 *	操作结果：删除L的第i个节点，并用e返回其值，L的长度减1
 *	问题：明明删除的元素是第二个，为啥总变成后一个？插入也是
 */
Status ListDelete(LinkList L, int i, ElemType *e)
{
	int j = 1;
	LinkList p, q;
	q = (LinkList)malloc(sizeof(Node));
	p = L->next;

	while (p->next && j<i)
	{
		p = p->next;
		++j;
	}
	if (!(p->next) || j>i) //其实改写的方法还挺多的，可以使用break来返回状态
	{
		return ERROR;
	}
	q = p->next;
	p->next = q->next;
	*e = q->data;
	free(q);
	
	return OK;
}
/**/
//测试从线性链表中取值的函数
void main()
{
	int s;
	ElemType del_node;
	LinkList L = (LinkList)malloc(sizeof(Node));
	
	Node n1, n2, n3, n4, n5;
	n1.data = 1;
	n2.data = 2;
	n3.data = 3;
	n4.data = 4;
	n5.data = 5;
	n1.next = &n2;
	n2.next = &n3;
	n3.next = &n4;
	n4.next = &n5;
	n5.next = NULL;

	L->data = 0;
	L->next = &n1;

	s = ListDelete(L, 2, &del_node);  //注意这里是如何传递结构体指针的，直接传递地址即可
	LinkList p;// = (LinkList)malloc(sizeof(Node));
	p = L->next;
	for (int i = 1; i <= 4; i++)
	{
		printf("n[%d] = %d\n", i, p->data);
		p = p->next;
	}
	printf("del_node = %d\nStatus = %d\n", del_node, s);
}













