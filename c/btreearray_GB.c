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

typedef TElemType SqBitree[MAX_TREE_SIZE];

typedef struct
{
	int level;//
	int order;// 
}Position;

Status InitBiTree(SqBitree T)
{
	int i;
	for(i=0;i<MAX_TREE_SIZE;i++)
	{
		T[i] = 0;
	}
	return OK;
}
//按层序次序输入二叉树中结点的值(字符型或整型), 构造顺序存储的二叉树T
Status CreateBiTree(SqBitree T)
{
	int i=0;
	printf("请按层序输入结点的值(整型)，0表示空结点，输999结束。结点数≤%d:\n",MAX_TREE_SIZE);
	
	///////////////////////////////////////////////////////////|这部分是初始化了一个完全二叉树
	while(i<10)										  /////////|T中存储的是节点的排序
	{                                                 /////////|T中初始反映的信息是第几个节点
		T[i] = i+1;                                   /////////|节点的数据可以自己以后赋值
		if(i!=0 && T[(i+1)/2-1]==0 && T[i]!=0)        /////////|
		{                                             /////////|
			printf("出现无双亲的非根结点%d\n",T[i]);    /////////|
			return ERROR;                             /////////|
		}                                             /////////|
		i++;                                          /////////|
	}                                                 /////////|
	///////////////////////////////////////////////////////////|
	while(i<MAX_TREE_SIZE)
	{
		T[i] = 0;
		i++;
	}
	return OK;
}

// 初始条件: 二叉树T存在 
// 操作结果: 若T为空二叉树,则返回TRUE,否则FALSE 
Status BiTreeEmpty(SqBitree T)
{
	if(T[0]==0)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}
//初始条件: 二叉树T存在 
//操作结果: 返回树的深度
/* 注：深度为k的满二叉树的节点数为n，则n与k的关系为 n = (2^k)-1
 *     完全二叉树的节点数n，深度k的关系 n<(2^k)-1
 *     在顺序存储中最后一个节点也是这个二叉树的节点数
 *     而顺序存储又是按照完全二叉树数映射进数组的
 *     所以在计算深度时可以使用下面的计算公式
 */
int BiTreeDepth(SqBitree T)
{
	int i,j=-1;
	for(i=MAX_TREE_SIZE-1;i>=0;i--)
	{
		if(T[i] != 0) break;//找到最后一个节点
	}
	i++;//将最后一个节点加1
	do
	{
		j++;
	}while(i>=pow(2,j));//do-while 语句现做在循环
	return j;
}
//初始条件: 二叉树T存在 
//操作结果: 返回树的根节点值
Status Root(SqBitree T,TElemType *e)
{
	if(BiTreeEmpty(T))
	{
		return ERROR;
	}
	else
	{
		*e = T[0];
		return OK;
	}
}
//初始条件: 二叉树T存在，e是T中的某个节点
//操作结果: 返回处于位置e的节点的值
TElemType Value(SqBitree T, Position e)
{
	return T[(int)pow(2,e.level-1)+e.order-2];
}

//初始条件：二叉树T存在，e是T中某个节点的位置
//操作结果：给处于位置e的节点赋新值value
//问题：我怎样才能让一个二叉树的节点数据存0呢？
Status Assign(SqBitree T,Position e,TElemType value)
{
	int i=(int)pow(2,e.level-1)+e.order-2;
	if(value != 0 && T[(i+1)/2-1]==0)//二叉树中数据不能为0？后面的条件是被赋值节点的父节点不能为0
	{								//父节点的孩子节点不能为0？
		return ERROR;
	}
	else if(value==0 && (T[i*2+1] != 0 || T[i*2+2] != 0))//value为0，其左右孩子节点存在不为0的节点
	{													//如果一个节点有孩子节点，那么他的节点数值就不能为0	
		return ERROR;									//这是什么道理？
	}
	//上面说的一件事，就是如果父节点为0，那么被赋值的孩子节点也得为0；
	//如果被赋值的父节点为0，那么被赋值节点的左右孩子节点都得是0；
	//也就是说0不能作为任意节点的父节点，
	//这保证的是这个二叉树为完全二叉树，只有倒数第一层的左边和倒数第二层的右边可以有叶子节点
	T[i] = value;
	return OK;
}

//初始条件：二叉树T存在，e是T中某个节点的位置
//操作结果：如果非根节点e的双亲
TElemType Parent(SqBitree T, TElemType e)
{
	int i;
	if(T[0] == 0)
	{
		return 0;
	}
	for(i=1;i<=MAX_TREE_SIZE-1;i++)		///|返回双亲节点   return T[(i+1)/2-1];
	{                                   ///|返回左孩子节点 return T[i*2+1];
		if(T[i]==e) return T[(i+1)/2-1];///|返回右孩子节点 return T[i*2+2];
	}                                   ///|返回兄弟节点 if判断i是否为奇数判断左右孩子   return T[i+1]
	return 0;
}

//初始条件：存在非空二叉树T
//操作结果：逐层逐层序输出二叉树
Status Print(SqBitree T)
{
	int j,k;
	Position p;
	TElemType e;
	for(j=1;j<=BiTreeDepth(T);j++)
	{
		printf("第%d层:",j);
		for(k=1;k<=pow(2,j-1);k++)
		{
			p.level = j;
			p.order = k;
			e = Value(T,p);
			if(e!=0)
			{
				printf("%d:%d ",k,e);
			}
		}
		printf("\n");
	}
	return OK;
}

Status visit(TElemType c)
{
	printf("%d",c);
	return OK;
}


//遍历二叉树 根左右（前序）
void PreTraverse(SqBitree T, int e)
{
	visit(T[e]);//root
	if(T[2*e+1]!=0)//left
	{
		PreTraverse(T,2*e+1);
	}
	if(T[2*e+2]!=0)//right
	{
		PreTraverse(T,2*e+2);
	}
}

//遍历二叉树 左根右（中序）
void InTraverse(SqBitree T, int e)
{
	if(T[2*e+1]!=0)//left
	{
		PreTraverse(T,2*e+1);
	}
	visit(T[e]);//root
	if(T[2*e+2]!=0)//right
	{
		PreTraverse(T,2*e+2);
	}
}

//遍历二叉树 左右根（后序）
void PostTraverse(SqBitree T, int e)
{
	if(T[2*e+1]!=0)//left
	{
		PreTraverse(T,2*e+1);
	}
	if(T[2*e+2]!=0)//right
	{
		PreTraverse(T,2*e+2);
	}
	visit(T[e]);//root
}

//前序遍历二叉树（中序）（后序）
Status OrderTraverse(SqBitree T)
{
	if(!BiTreeEmpty(T))
	{
		PreTraverse(T,0);
	}
	printf("\n");
	return OK;
}




void main()
{
	Status init_x,crea_x,isempty_x,depth_x,root_x,ass_x,par_x,pri_x,pre_x;
	TElemType e,e1;
	SqBitree T;
	init_x = InitBiTree(T);
	printf("%d\n",init_x);
	crea_x = CreateBiTree(T);
	printf("%d\n",crea_x);
	isempty_x = BiTreeEmpty(T);
	printf("%d\n",isempty_x);
	depth_x = BiTreeDepth(T);
	printf("%d\n",depth_x);
	root_x = Root(T,&e);
	printf("%d\n",root_x);
	Position ee = {1,1};
	e1 = Value(T, ee);
	printf("%d\n",e1);
	ass_x = Assign(T,ee,5);
	printf("%d\n",ass_x);
	e1 = Value(T, ee);
	printf("%d\n",e1);
	par_x = Parent(T,2);
	printf("%d\n",par_x);
	pri_x = Print(T);
	printf("%d\n",pri_x);
	pre_x = OrderTraverse(T);
	printf("%d\n",pre_x);
}
