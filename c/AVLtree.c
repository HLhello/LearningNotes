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