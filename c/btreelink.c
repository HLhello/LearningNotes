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

typedef int Status;
typedef char TElemType;

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

int index;
typedef char String[24];
String str;

Status StrAssign(String T, char *chars)
{
	int i;
	if(strlen(chars)>MAXSIZE)
	{
		return OK;
	}
	else
	{
		T[0] = strlen(chars);
		for(i=1;i<=T[0];i++)
		{
			T[i] = *(chars+i-1);
		}
		return OK;
	}
}

Status visit(TElemType e)
{
	printf("%c",e);
	return OK;
}

Status InitBitree(Bitree *T)
{
	*T = NULL;
	return OK;
}

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
	return OK;
}
//创建一颗树
void CreateBitree(Bitree *T)
{
	TElemType ch;
	ch = str[index++];

	if(ch == '#')
	{
		*T = NULL;
	}
	else 
	{
		*T = (Bitree)malloc(sizeof(BitreeNode));
		if(!*T)
		{
			return ERROR;
		}
		(*T)->data = ch;
		CreateBitree(&(*T)->lchild);
		CreateBitree(&(*T)->rchild);
	}
}

int BiTreeDepth(Bitree T)
{
	int i,j;
	if(!T)
	{
		return 0;
	}

	if(T->lchild)
	{
		i = BiTreeDepth(T->lchild);
	}
	else
	{
		i = 0;
	}

	if(T->rchild)
	{
		j = BiTreeDepth(T->rchild);
	}
	else
	{
		j = 0;
	}

	return i>j?i+1:j+1;
}


void main()
{

}


















































