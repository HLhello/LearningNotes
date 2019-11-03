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
//link 表示指向左右孩子的指针，thread表示指向前驱或后继的线索
typedef enum {Link,Thread} PointerTag;
typedef struct BithrNode
{
    TElemType data;
    struct BithrNode *lchild;
    struct BithrNode *rchild;
    PointerTag Ltag;
    PointerTag Rtag;
}BithrNode, *BithrTree;
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
        if(!*T)
        {
            exit(0);
        }
        (*T)->data = h;
        CreatBithrTree((*T)->lchild);
        if((*T)->lchild)
        {
            (*T)->Ltag=Link;
        }
        CreatBithrTree((*T)->rchild);
        if((*T)->rchild)
        {
            (*T)->Rtag=Link;
        }

    }
    return OK;
}

BithrTree pre;
void Inthreading(BithrTree p)
{
    if(p)
    {
        Inthreading(p->lchild);
        if(!p->lchild)
        {
            p->Ltag = Thread;
            p->lchild = pre;
        }
        if(!pre->rchild)
        {
            pre->Rtag = Thread;
            p->rchild = pre;
        }
        pre = p;
        Inthreading(p->rchild);
    }         
}

Status InorderThreading(BithrTree *Thrt, BithrTree T)
{
    *Thrt=(BithrTree)malloc(sizeof(BithrNode));
    if(!*Thrt)
    {
        exit(0);
    }
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
        
    }
    
}






