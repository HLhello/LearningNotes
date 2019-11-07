#include<stdio.h>
#include<stdlib.h>
#include<io.h>
#include<math.h>
#include<time.h>

#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0
#define MAXSIZE 100 //存储空间初始分配量

typedef int Status;	// Status是函数的类型,其值是函数结果状态代码，如OK等

typedef struct BiTNode
{
    int data;
    struct BiTNode *lchild;
    struct BiTNode *rchild;
} BiTNode, *BiTree;

//查找二叉树中是否有key，运用递归的思想

Status SearchBST(BiTree T, int key, BiTree f, BiTree *p)
{
    if(!T)
    {
        *p = f;
        return FALSE;
    }
    else if(key==T->data)
    {
        *p = T;
        return TRUE;
    }

}
