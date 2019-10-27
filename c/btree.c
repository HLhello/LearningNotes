#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<time.h>
#include<io.h>

#define OK 1
#define ERROR 0
#define TURE 1
#define FALSE 0

#define MAXSIZE 100 //存储空间初始分配量
#define MAX_TREE_SIZE 100 // 二叉树的最大结点数

typedef int Status;
typedef int TElemType;

/*
 * ADT 树（tree）
 * Data
 * 	   树是由一个根节点和若干颗子树构成，树中节点具有相同数据类型及层次关系
 * Operation
 * 	   InitTree(*T)
 * 	   DestortyTree(*T)
 * 	   CreateTree(*T,definition)
 * 	   ClearTree(*T)
 * 	   TreeEmpty(T)
 * 	   TreeDepth(T)
 * 	   Root(T)
 * 	   Value(T,*cur_e)
 * 	   Assign(T,cur_e,value)
 * 	   Parent(T,cur_e)
 * 	   LiftChild(T,cur_e)
 * 	   RightSibling(T,cur_e)
 * 	   InsertChild(*T,*p,i,c)
 * 	   DeleteChild(*T,*p,i)
 * endADT
 */

typedef TElemType SqBitree[MAX_TREE_SIZE];

typedef struct
{
	int level;//
	int order;// 
}Position;

Status InitTree(SqBitree T)
{
	int i;
	for(i=0;i<MAX_TREE_SIZE;i++)
	{
		T[i] = 0;
	}
	return OK;
}
//按层序次序输入二叉树中结点的值(字符型或整型), 构造顺序存储的二叉树T
Status CreateTree(SqBitree T)
{
	int i=0;
	printf("请按层序输入结点的值(整型)，0表示空结点，输999结束。结点数≤%d:\n",MAX_TREE_SIZE);
	while(i<10)
	{
		T[i] = i+1;
		if(i!=0 && T[(i+1)/2-1]==0 && T[i]!=0)
		{
			printf("出现无双亲的非根结点%d\n",T[i]);
			return ERROR;
		}
		i++;
	}
	
	while(i<MAX_TREE_SIZE)
	{
		T[i] = 0;
		i++;
	}
	return OK;
}

//逐层，按本层序号输出二叉树
Status print(SqBitree T)
{
	int j,k;
	
}



void main()
{
	Status init_x,crea_x;
	SqBitree T;
	init_x = InitTree(T);
	printf("%d\n",init_x);
	crea_x = CreateTree(T);
	printf("%d\n",crea_x);
}







































