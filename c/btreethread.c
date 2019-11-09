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
typedef int Status;
typedef char TElemType;
typedef enum {Link,Thread} PointerTag;//link 表示指向左右孩子的指针，thread表示指向前驱或后继的线索
typedef struct BithrNode
{
    TElemType data;
    struct BithrNode *lchild;
    struct BithrNode *rchild;
    PointerTag Ltag;
    PointerTag Rtag;
}BithrNode, *BithrTree;
//已知前序和后序遍历是不能确定一颗二叉树的
BithrTree pre;//始终指向刚刚访问过的节点

Status visit(TElemType e)
{
    printf("%c ",e);
    return OK;
}

Status CreatBithrTree(BithrTree *T)
{
    TElemType h;
    scanf("%c",&h); 

    if(h=='#')
    {
        *T = NULL;
    }
    else
    {
        *T = (BithrTree)malloc(sizeof(BithrNode));
        if(!*T) exit(_OVERFLOW);
        (*T)->data = h;
        
        CreatBithrTree(&(*T)->lchild);
        if((*T)->lchild) (*T)->Ltag=Link;

        CreatBithrTree(&(*T)->rchild);
        if((*T)->rchild) (*T)->Rtag=Link;
    }
    return OK;
}

void PreOrderTra(BithrTree T)
{
	if(T==NULL) return;
	printf("%c",T->data);
	PreOrderTra(T->lchild);
	PreOrderTra(T->rchild);
}
//中序遍历二叉树
void InOrderTra(BithrTree T)
{
	if(T==NULL) return;
	PreOrderTra(T->lchild);
	printf("%c",T->data);
	PreOrderTra(T->rchild);
}
/*
//测试穿件二叉树函数
void main()
{
    BithrTree T;
    CreatBithrTree(&T);
    PreOrderTra(T);
}
*/
//中序遍历进行中序线索化
void Inthreading(BithrTree p)
{
    if(p)
    {
        Inthreading(p->lchild);
        //***********************************
        if(!p->lchild)
        {
            p->Ltag = Thread;
            p->lchild = pre;//pre 是个空的节点啊
        }
        if(!pre->rchild)
        {
            pre->Rtag = Thread;
            p->rchild = pre;
        }
        pre = p;
        //***********************************
        Inthreading(p->rchild);
    }         
}
//存在问题，还没理解线索二叉树。线索化倒是知道怎么弄了，双向链表怎么回事
//中序遍历二叉树T，并将其中序线索化，Thrt指向头结点
Status InorderThreading(BithrTree *Thrt, BithrTree T)
{
    *Thrt=(BithrTree)malloc(sizeof(BithrNode));
    if(!*Thrt) exit(_OVERFLOW);

    (*Thrt)->Ltag = Link;
    (*Thrt)->Rtag = Thread;
    
    (*Thrt)->rchild = (*Thrt);
    if(!T)
    {
        (*Thrt)->lchild = *Thrt;
    }
    else
    {
        (*Thrt)->lchild = T;
        pre = (*Thrt);
        Inthreading(T);
        pre->rchild = *Thrt;
        pre->Rtag = Thread;
        (*Thrt)->rchild = pre;
    }
    return OK;
}
//中序遍历二叉线索树T（头结点）的非递归算法
Status InOrderTra_Thr(BithrTree T)
{
    BithrTree p = T->lchild;
    while(p!=T)
    {
        while(p->Ltag==Link) p = p->lchild;
        if(!visit(p->data)) return ERROR;
        while(p->Rtag==Thread && p->rchild!=T)
        {
            p = p->rchild;
            visit(p->data);
        }
        p = p->rchild;
    }
    return OK;
}
int main()
{
	BithrTree H,T;
	printf("请按前序输入二叉树(如:'ABDH##I##EJ###CF##G##')\n");
 	CreatBithrTree(&T); /* 按前序产生二叉树 */
	InorderThreading(&H,T); /* 中序遍历,并中序线索化二叉树 */
	printf("中序遍历(输出)二叉线索树:\n");
	InOrderTra_Thr(H); /* 中序遍历(输出)二叉线索树 */
	printf("\n");
	
	return 0;
}




