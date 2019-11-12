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

#define LH +1 //左高
#define EH 0  //等高
#define RH -1 //右高

#define MAXSIZE 100 //存储空间初始分配量
typedef int Status;
//平衡二叉树是二叉排序树的特殊情况
//平衡二叉树不是完全二叉树
typedef struct BiTNode
{
    int data;
    int bf;    //平衡因子，左 - 右
    struct BiTNode *lchild;
    struct BiTNode *rchild; 
}BiTNode, *Bitree;

void R_Rotate(Bitree *p)
{
    Bitree L;
    L = (*p)->lchild;
    (*p)->lchild = L->rchild;
    L->rchild = (*p);
    *p = L;
}

void L_Rotate(Bitree *p)
{
    Bitree R;
    R = (*p)->rchild;
    (*p)->rchild = R->rchild;
    R->lchild = (*p);
    *p = R;
}

void LeftBalance(Bitree *T)
{
    Bitree L, Lr;
    L = (*T)->lchild;
    switch(L->bf)
    {
        case LH:
            (*T)->bf = EH;
            L->bf = EH;
        case RH:
            Lr = L->rchild;
            switch(Lr->bf)
            {
                case LH: (*T)->bf = RH;
                         L->bf = EH;
                         break;
                case EH: (*T)->bf = EH;
                         L->bf = EH;
                         break;
                case RH: (*T)->bf = EH;
                         L->bf = LH;
                         break;
            }
            Lr->bf = EH;
            L_Rotate(&(*T)->lchild);
            R_Rotate(T);
    }
}

void RightBlance(Bitree *T)
{
    Bitree R,Rl;
    R = (*T)->rchild;
    switch(R->bf)
    {
        case RH:
            (*T)->bf = EH;
            R->bf = EH;
            break;     
        case LH:
            Rl - R->lchild;
            switch(Rl->bf)
            {
                case RH: (*T)->bf = LH;
                         R->bf = EH;
                         break;
                case EH: (*T)->bf = EH;
                         R->bf = EH;
                         break;
                case LH: (*T)->bf = EH;
                         R->bf = RH;
                         break;
            }
            Rl->bf = EH;
            R_Rotate(&(*T)->rchild);
            L_Rotate(T);
    }
}