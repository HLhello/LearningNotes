#include<stdio.h>
#include<stdlib.h>
#include<io.h>
#include<math.h>
#include<time.h>

#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0
/* ADT 队列（queue）
 * Data
 * 	   同线性表，元素具有相同的类型，相邻元素具有前驱和后继的关系
 * Operation
 * 	   InitQueue(*Q)初始化操作，建立一个空队列Q
 * 	   DestroyQueue(*Q)若队列Q存在，则销毁他
 * 	   ClearQueue(*Q)将队列清空
 * 	   QueueEmpty(Q)若队列Q为空，返回True，否则返回False
 * 	   GetHead(Q,*e)若队列存在且非空，用e返回队头元素
 * 	   EnQueue(*Q,e)若队列存在，插入新元素e到队列中并成为队尾元素
 * 	   DeQueue(*Q,e)删除队列Q中的队头元素，并用e返回其值
 * 	   QueueLength(Q)返回队列的元素个数
 * endADT
 */

typedef int Status; 
typedef int QElemType; //SElemType类型根据实际情况而定，这里假设为int 

typedef struct QNode
{
	QElemType data;
	struct QNode *next;
}QNode,*Qptr;

typedef struct 
{
	Qptr front;
	Qptr rear;
}QueueLink;
//如何初始化一个队列链表呢
Status InitQueue(QueueLink *QL,Qptr qn)
{
	qn->next = NULL;
	QL->front = qn;
	QL->rear = qn;
}


Status EnQueue(QueueLink *QL, QElemType e)
{
	Qptr qp = (Qptr)malloc(sizeof(QNode));//创建一个新的节点
	if(!qp)//判断内存是否分配成功
	{
		exit(0);
	}
	
	qp->data = e;//为节点赋值
	qp->next = NULL;//因为是入队，多以是最后一个节点，在单链表中，我们将最后一个节点指针域赋值为NULL
	QL->rear->next = qp;//将创建好的指针连接在单链表上
	QL->rear = qp;//移动尾指针，使其指向新的尾节点
	return OK;
}

Status DeQueue(QueueLink *QL, QElemType *e)
{
	if(QL->front == QL->rear)//若链式存储队列的头指针和尾指针相同，则证明链表中没有元素
	{
		return ERROR;
	}
	else
	{
		Qptr qp = (Qptr)malloc(sizeof(QNode));//创建一个节点，用来接收将要删除的节点
		qp = QL->front->next;//将创建的节点指向要出队的元素
		*e = qp->data;//将要出队的元素的数据成员赋给*e
		QL->front->next = qp->next;//将头指针的下一节点改成出队元素的下一节点
		if(QL->rear == qp)//如果尾指针指向的是要出队的节点
		{
			QL->rear = QL->front;//因为要释放出队节点的内存，就要将尾指针和头指针共同指向初始化时的节点
		}
		free(qp);//释放内存
	}
	return OK;
}

void main()
{
	QueueLink QL;
	QNode qn;
	// qn.next = NULL;
	// QL.front = &qn;
	// QL.rear = &qn;
	Status init_x,en_x,de_x,qq;
	init_x = InitQueue(&QL,&qn);
	en_x = EnQueue(&QL,5);
	printf("%d\n",en_x);
	printf("%d\n",QL.rear->data);
	de_x = DeQueue(&QL,&qq);
	printf("%d\n",de_x);
	printf("%d\n",qq);
	
}














