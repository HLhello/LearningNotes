#include <stdio.h>    
#include <string.h>
#include <ctype.h>      
#include <stdlib.h>   
#include <io.h>  
#include <math.h>  
#include <time.h>

#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0

#define MAXSIZE 10  //先改成100，后面测试时间性能再说

typedef int Status;
typedef struct 
{
    int r[MAXSIZE+1];//用于存储要排序的数组，r[0]用作哨兵或临时变量
    int length;
}Sqlist;

//将*L序列中的第i个值与第j个值进行交换
void swap(Sqlist *L, int i, int j)
{
    int temp = L->r[i];
    L->r[i] = L->r[j];
    L->r[j] = temp;
}

void print(Sqlist L)
{
    int i;
    for(i=1; i<L.length; i++)
    {
        printf("%d, ",L.r[i]);
    }
    printf("%d",L.r[i]);//这样做有什么意义么？
    //有，最后一个没有'，'号
    printf("\n");
}

void Bubblesort0(Sqlist *L)
{
    int i,j;
    for(i=1;i<L->length;i++)
    {
        for(j=i+1;j<=L->length;j++)
        {
            if(L->r[i]>L->r[j]) swap(L,i,j);
        }
    }
}

void generateL(Sqlist *L)
{
    time_t theTime;
    srand((unsigned int)time(&theTime));
    
    L->length = 0;

    for(int i=1;i<=MAXSIZE;i++)//L.r[0]用作哨兵值
    {//当i<=MAXSIZE+1 的时候，L.length=L.r[MAXSIZE+1],这是为啥？bug？ -_-！
        L->length++;
        L->r[i] = rand()/1000;
    }
    printf("the original L's length: %d\n",L->length);
    printf("the original L: ");
    print(*L);
}

void main()
{   
    Sqlist L;
    generateL(&L);
    L.r[5] = 1001;
    print(L);
}