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

#define MAXSIZE 100

typedef int Status;
//bst的结构不难，难点在将二叉树链表构建起来，并且在合适的地方插入数据
typedef struct BiTNode
{
    int data;
    struct BiTNode *lchild;
    struct BiTNode *rchild;
}BiTNode, *Bitree;

//递归查找二叉排序树T中是否存在key
//指针f指向T的双亲，其初始值为NULL
//若查找成功，则指针p指向该数据元素节点，并且返回TRUE
//若查找不成功，则指针p指向查找路径上访问的最后一个节点并且返回FALSE
Status SearchBST(Bitree T, int key, Bitree f, Bitree *p)
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
    else if(key<T->data)
    {
        return SearchBST(T->lchild, key, T, p);
    }
    else
    {
        return SearchBST(T->rchild, key, T, p);
    }
    return OK;
}

Status InsertBST(Bitree *T, int key)
{
    Bitree p,s;
    if(!SearchBST(*T, key, NULL, &p))
    {
        s = (Bitree)malloc(sizeof(BiTNode));
        s->data = key;
        s->lchild = NULL;
        s->rchild = NULL;
        
        if(!p) *T = s;
        else if(key<p->data) p->lchild = s;
        else if(key>p->data) p->rchild = s;
        
        return TRUE;
    }
    else
    {
        return FALSE;
    }
    return OK;
}

Status pDelete(Bitree *p)
{
    Bitree q,s;
    if((*p)->rchild==NULL)
    {
        q = *p; 
        *p = (*p)->lchild;
        free(q);
    }
    else if((*p)->lchild==NULL)
    {
        q = *p; 
        *p = (*p)->rchild;
        free(q);
    }
    else
    {
        q=*p;
        s = (*p)->lchild;
        while(s->rchild)
        {
            q = s;
            s = s->rchild;   
        }
        (*p)->data = s->data;
        if(q!=*p) q->rchild = s->lchild;
        else q->lchild = s->lchild;
        free(s);
    }
    return TRUE;
}

Status DeleteBST(Bitree *T, int key)
{
    if(!*T)
    {
        return FALSE;
    }
    else
    {
        if(key==(*T)->data) 
            return pDelete(T);
        else if(key<(*T)->data) 
            return DeleteBST(&(*T)->lchild, key);
        else
            return DeleteBST(&(*T)->rchild, key);
    }
    return OK;
}

void InOrderTra(Bitree T)
{
	if(T==NULL) return;
	InOrderTra(T->lchild);
	printf("%d,",T->data);
	InOrderTra(T->rchild);
}


void main()
{
    int a[10] = {62,88,58,47,35,73,51,99,37,93};
    Bitree T = NULL;

    for(int i=0;i<10;i++)
    {
        InsertBST(&T, a[i]);
    }
    InOrderTra(T);
    printf("\n");

    DeleteBST(&T,93);
    InOrderTra(T);
    printf("\n");
    
    DeleteBST(&T,47);
    InOrderTra(T);
}


