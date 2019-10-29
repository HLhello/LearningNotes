#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<time.h>
#include<io.h>

#define OK 1
#define ERROR 0
#define TRUE 1
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

typedef struct BiTreeNode
{
	TElemType data;
	struct BiTreeNode *lchild;
	struct BiTreeNode *rchild;
}BitreeNode,*Bitree;

//销毁一棵树，使用递归的思想
Status DestortyTree(Bitree *T)
{
	if(*T)
	{
		if((*T)->lchild)
		{
			DestortyTree(&((*T)->lchild));
		}
		if((*T)->rchild)
		{
			DestortyTree(&((*T)->rchild));
		}
		free(*T);
		*T = NULL;
	}
	return OK:
}



















































