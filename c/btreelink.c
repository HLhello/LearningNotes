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

typedef struct BiTNode
{
	TElemType data;
	struct BiTNode *lchild;
	struct BiTNode *rchild;
}BiTNode,*Bitree;

int ind = 1;
typedef char String[MAXSIZE];//设置全局变量的模板
String str;//定义一个字符串的全局变量

/*******************************************************************/
// 初始条件: 字符串存T存在，字符串数组char存在
// 操作结果: 将字符串数组赋值给字符串T，为字符串赋值，字符串的第一个元素为长度
// 存在问题：
Status StrAssign(String T, char *chars)
{
	int i;
	if(strlen(chars)>MAXSIZE)//将字符串的长度赋值给T[0]，但是T[0]为char型数据
	{						 //char只有一个字节的长度，所以字符串最大不能超过256
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
/*******************************************************************/
/*
//测试给字符串的赋值函数
void main()
{
	Status strA_x;
	String T;
	char chars[] = {"I love China"};
	strA_x = StrAssign(T,chars);
	printf("%d\n",strA_x);
	for(int i=0;i<=strlen(chars);i++)
	{
		if(i==0)
		{
			printf("%d ",T[i]);
		}						
		else 					
		{
			printf("%c",T[i]);	
		}
	}
}
*/
//输出传入的元素
Status visit(TElemType e)
{
	printf("%c ",e);
	return OK;
}
//创建空的二叉树T
Status InitBiTree(Bitree *T)
{
	*T = NULL;
	return OK;
}
/*
//测试创建空的二叉树
void main()
{
	Bitree T;
	int init_x = InitBiTree(&T);
	printf("%d\n", init_x);
	printf("%d\n",sizeof(T));
	printf("%d\n",sizeof(*T));
	
}
*/

// 初始条件: 存在一颗初始化的树，需要女使用一个全局变量index_以及一个全局变量的字符串
// 操作结果: 将以全局变量的字符串str创建一个存储字符的树结构(按照前序构建一颗二叉树)
// 存在问题：
/*
在内存中建立一颗二叉树，为了能让每个节点确定是否有左右孩子需要对二叉树进行扩展
也就是将二叉树中的每个节点的空指针指向一个虚节点，其值为一个特定值，比如‘#’
处理后的二叉树为原二叉树的扩展二叉树
扩展二叉树就可以做到一个遍历序列确定一颗二叉树
注意：扩展二叉树并不是完全二叉树
他妈的在这走了好几天的弯路，气死老子了
*/
//按照前序遍历的结构建立二叉树
void CreateBiTree(Bitree *T)//这是个二级指针
{ 
	TElemType ch;
	ch=str[ind++];//使用全局变量，这是先使用在自加

	if(ch=='#')//如果出现#，将指针直线空
	{
		*T=NULL;
	}
	else
	{
		*T=(Bitree)malloc(sizeof(BiTNode));
		
		if(!*T) exit(_OVERFLOW);
		
		(*T)->data=ch;
		CreateBiTree(&(*T)->lchild);
		CreateBiTree(&(*T)->rchild);
	}
 }

Status BitreeEmpty(Bitree T)
{
	if(T==NULL) return TRUE;
	else return FALSE;
}

/*
//测试createBITree
void main()
{
	int strA_x, init_x, emp_x;
	//char chars[] = {"ABCDEF"};
	//printf("%s\n","ABDH#K###E##CFI###G#J##");
	strA_x = StrAssign(str, "AB#D##C##");
	printf("strA_x = %d\n",strA_x);
	Bitree T;
	init_x = InitBiTree(&T);
	printf("init_x = %d\n",init_x);
	emp_x = BitreeEmpty(T);
	printf("emp_x = %d\n",emp_x);
	CreateBiTree(&T);
	emp_x = BitreeEmpty(T);
	printf("emp_x = %d\n",emp_x);
}
*/

int BiTreeDepth(Bitree T)
{
	int i,j;
	if(!T) return 0;
	
	if(T->lchild) i = BiTreeDepth(T->lchild);
	else i = 0;
	
	if(T->rchild) j = BiTreeDepth(T->rchild);
	else j = 0;

	return i>j ? i+1 : j+1;
}

//输出二叉树T的根节点
TElemType BitreeRoot(Bitree T)
{
	if(!T) return '#';
	else return T->data;
}

//为二叉树节点p赋值value
void Assign(Bitree p, TElemType value)
{
	p->data = value;
}

//二叉树T存在，p指向T中的某个节点，输出节点的数据
TElemType value(Bitree p)
{
	return p->data;
}
//前序遍历二叉树
void PreOrderTra(Bitree T)
{
	if(T==NULL) return;
	printf("%c",T->data);
	PreOrderTra(T->lchild);
	PreOrderTra(T->rchild);
}
//中序遍历二叉树
void InOrderTra(Bitree T)
{
	if(T==NULL) return;
	PreOrderTra(T->lchild);
	printf("%c",T->data);
	PreOrderTra(T->rchild);
}

//后序遍历二叉树
void PostOrderTra(Bitree T)
{
	if(T==NULL) return;
	PreOrderTra(T->lchild);
	PreOrderTra(T->rchild);
	printf("%c",T->data);
}

void DestoryBiTree(Bitree *T)
{
	if(*T)
	{
		if((*T)->lchild) DestoryBiTree(&(*T)->lchild);
		if((*T)->rchild) DestoryBiTree(&(*T)->rchild);
		free(*T);
		*T = NULL;
	}
}
/**/
void main()
{
	Bitree T;
	StrAssign(str, "AB#C##D##");
	InitBiTree(&T);
	CreateBiTree(&T);
	int depth = BiTreeDepth(T);
	printf("depth = %d\n", depth); 
	TElemType Btroot = BitreeRoot(T);
	printf("root = %c\n", Btroot);
	PreOrderTra(T);
	printf("\n");
	InOrderTra(T);
	printf("\n");
	PostOrderTra(T);
	DestoryBiTree(&T);
	printf("\n");
	if(!T) 
	{
		TElemType Btroot = BitreeRoot(T);
		printf("root = %c\n", Btroot);//#-->表示空
		printf("Destory BiTree Done");
	}
	
}


















































