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
 
 #define MAXSIZE 20 // 存储空间初始分配量
typedef int Status; 
typedef int QElemType; //SElemType类型根据实际情况而定，这里假设为int 

typedef struct
{
	QElemType data[MAXSIZE];
	int front;
	int rear;
}SqQueue;

Status InitQueue(SqQueue *Q)
{
	Q->front = 0;
	Q->rear = 0;
	return OK;
}

int QueueLength(SqQueue Q)
{
	return (Q.rear - Q.front +MAXSIZE)%MAXSIZE;//计算长度的公式
}

Status EnQueue(SqQueue *Q, QElemType e)
{
	if((Q->rear+1)%MAXSIZE == Q->front)//判断长度的公式
	{
		return ERROR;
	}
	else 
	{
		Q->data[Q->rear] = e;
		Q->rear = (Q->rear+1)%MAXSIZE;
	}
	return OK;
}

Status DeQueue(SqQueue *Q, QElemType *e)
{
	if(Q->front == Q->rear)
	{
		return ERROR;
	}
	else 
	{
		*e = Q->data[Q->front];
		Q->front = (Q->front+1)%MAXSIZE;
	}
	return OK;
}

void main()
{
	Status init_x,en_x,de_x;
	SqQueue Q;
	init_x = InitQueue(&Q);
	printf("%d",init_x);
	printf("%d",Q.rear);
	printf("%d\n",Q.front);
	for(int i=0;i<19;i++)
	{
		en_x = EnQueue(&Q,i);
		printf("%-3d",Q.data[i]);
	}
	printf("\n%d\n",en_x);
	en_x = EnQueue(&Q,19);
	printf("%d\n",en_x);
	int e[20];
	for(int i=0;i<9;i++)
	{
		de_x = DeQueue(&Q,&e[i]);
		printf("%-3d",e[i]);
	}
	printf("\n%d\n",de_x);
	for(int i=0;i<5;i++)
	{
		en_x = EnQueue(&Q,i);
		printf("%-3d",Q.data[i]);
	}	
	printf("\n%d\n",Q.rear);
	printf("%d\n",Q.front);
	for(int i=5;i<9;i++)
	{
		en_x = EnQueue(&Q,i);
		printf("%-3d",Q.data[i]);
	}	
	printf("\n%d\n",Q.rear);
	printf("%d\n",Q.front);
	en_x = EnQueue(&Q,10);
	printf("\n%d\n",en_x);
	for(int i=0;i<19;i++)
	{
		de_x = DeQueue(&Q,&e[i]);
		printf("%-3d",e[i]);
	}
	de_x = DeQueue(&Q,&e[20]);
	printf("\n%d\n",de_x);
	printf("\n%d\n",Q.rear);
	printf("%d\n",Q.front);
}



