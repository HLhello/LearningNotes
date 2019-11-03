#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<time.h>
#include<io.h>
#include<string.h>

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

typedef char String[24];
int index_;
String str;

// 初始条件: 字符串存T存在，字符串数组char存在
// 操作结果: 将字符串数组赋值给字符串T，为字符串赋值，字符串的第一个元素为长度
// 存在问题：
Status StrAssign(String T, char *chars)
{
	int i;
	if(strlen(chars)>MAXSIZE)
	{
		return ERROR;
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
//测试给字符串的赋值函数
/*
void main()
{
	Status stra_x;
	String T;
	char chars[] = {"I love China"};
	stra_x = StrAssign(T,chars);
	//printf("%d\n",stra_x);
	//printf("%d\n",strlen(chars));

	for(int i=0;i<=strlen(chars);i++)
	{
		if(i==0)
		{
			printf("%d",T[i]);
		}						
		else 					
		{
			printf("%c",T[i]);	
		}
	}
}
*/

// 初始条件: 存在一颗初始化的树，需要女使用一个全局变量index_以及一个全局变量的字符串
// 操作结果: 将以全局变量的字符串str创建一个存储字符的树结构(按照前序构建一颗二叉树)
// 存在问题：

// void CreateBitree(Bitree *T)
// {
// 	TElemType ch;

// 	ch = str[index_++];

// 	if(ch=='#')
// 	{
// 		*T = NULL;
// 	}
// 	else
// 	{
// 		*T=(Bitree)malloc(sizeof(BitreeNode));
// 		if(!*T)
// 		{
// 			exit(0);
// 		}
// 		(*T)->data = ch;
// 		CreateBitree(&(*T)->lchild);
// 		CreateBitree(&(*T)->rchild);
// 	}
// }
void CreateBitree(Bitree *T)
{ 
	TElemType ch;
	
	/* scanf("%c",&ch); */
	ch=str[index_++];

	if(ch=='#') 
		*T=NULL;
	else
	{
		*T=(Bitree)malloc(sizeof(BitreeNode));
		if(!*T)
			exit(OVERFLOW);
		(*T)->data=ch; /* 生成根结点 */
		CreateBitree(&(*T)->lchild); /* 构造左子树 */
		CreateBitree(&(*T)->rchild); /* 构造右子树 */
	}
 }
Status InitBiree(Bitree *T)
{
	*T = NULL;
	return OK;
}
void main()
{
	int ini_x,strA_x;
	Bitree T;
	ini_x = InitBiree(&T);
	strA_x = StrAssign(str, "ABDH#K###E##CFI###G#J##");
	CreateBitree(&T);
	printf("%d\n",strA_x);
}



































// void CreateBitree(Bitree *T)
// {
// 	TElemType ch;
// 	ch = str[index_++];

// 	if(ch == '#')//如果字符为#则表示当前没有分支
// 	{
// 		*T = NULL;
// 	}
// 	else 
// 	{
// 		*T = (Bitree)malloc(sizeof(BitreeNode));
// 		if(!*T)
// 		{
// 			exit(0);//如果内存分配不成功
// 		}
// 		(*T)->data = ch;
// 		CreateBitree(&(*T)->lchild);
// 		CreateBitree(&(*T)->rchild);
// 	}
// }

// void main()
// {
// 	Status strA_x;
// 	char chars[] = "ABCDEF";
// 	strA_x = StrAssign(str,chars);
// 	printf("%d\n",strA_x);
// 	BitreeNode T;// = (Bitree)malloc(sizeof(BitreeNode));
// 	CreateBitree(&T);
// 	//printf("%d\n",1);
// 	// printf("%d\n",emp_x);
// }
// Status BitreeEmpty(Bitree T)
// {
// 	if(T)
// 	{
// 		return FALSE;
// 	}
// 	else
// 	{
// 		 return TRUE;
// 	}
	
// }
// TElemType Root(Bitree T)
// {
// 	if(T)
// 	{
// 		return ' ';
// 	}
// 	else 
// 	{
// 		return T->data;
// 	}
// }




// //输出指定的元素
// Status visit(TElemType e)
// {
// 	printf("%c",e);
// 	return OK;
// }
// //初始化一颗树，让树指向NULL
// Status InitBitree(Bitree *T)
// {
// 	*T = NULL;
// 	return OK;
// }

// //销毁一棵树，使用递归的思想
// Status DestortyTree(Bitree *T)
// {
// 	if(*T)
// 	{
// 		if((*T)->lchild)
// 		{
// 			DestortyTree(&((*T)->lchild));
// 		}
// 		if((*T)->rchild)
// 		{
// 			DestortyTree(&((*T)->rchild));
// 		}
// 		free(*T);
// 		*T = NULL;
// 	}
// 	return OK;
// }
// int BiTreeDepth(Bitree T)
// {
// 	int i,j;
// 	if(!T)
// 	{
// 		return 0;
// 	}

// 	if(T->lchild)
// 	{
// 		i = BiTreeDepth(T->lchild);
// 	}
// 	else
// 	{
// 		i = 0;
// 	}

// 	if(T->rchild)
// 	{
// 		j = BiTreeDepth(T->rchild);
// 	}
// 	else
// 	{
// 		j = 0;
// 	}

// 	return i>j?i+1:j+1;
// }





















































