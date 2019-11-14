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

void generateL(Sqlist *L)
{
    time_t theTime;
    srand((unsigned int)time(&theTime));
    
    L->length = 0;

    for(int i=1;i<=MAXSIZE;i++)//L.r[0]用作哨兵值
    {//当i<=MAXSIZE+1 的时候，L.length=L.r[MAXSIZE+1],这是为啥？bug？ -_-！
        L->length++;
        L->r[i] = rand()%10;
    }
    printf("the original L's length: %d\n",L->length);
    printf("the original L: ");
    print(*L);
}

//1.1交换排序的一种
void Bubblesort0(Sqlist *L)
{
    int i,j;//设置两个游标
    for(i=1;i<L->length;i++)//i的取值范围是0到倒数第二个
    {
        for(j=i+1;j<=L->length;j++)//j的取值范围是第二个到最后一个
        {
            if(L->r[i]>L->r[j]) swap(L,i,j);//较大的数沉底
        }
    }
}

//1.2对顺序表L做冒泡排序，Bubblesort0与Bubblesort相比有什么区别
void Bubblesort(Sqlist *L)
{
    int i,j;
    for(i=1;i<L->length;i++)//i的取值范围是0到倒数第二个
    {
        for(j=L->length-1;j>=i;j--)//j的取值范围是倒数第二个到第一个
        {//从最后的两个数开始比较
            if(L->r[j]>L->r[j+1]) swap(L,j,j+1);//较大的数沉底
        }
    }
}
//1.3冒泡排序算法的改进 TODO
void Bubblesort1(Sqlist *L)
{
    int i,j;
    Status flag = TRUE;//没有想透彻，这个减少了那块的计算量？
    for(i=1; i<L->length && flag; i++)
    {
        flag = FALSE;
        for(j=L->length-1; j>=i; j--)
        {
            if(L->r[j]>L->r[j+1])
            {
                swap(L,j,j+1);
                flag = TRUE;
            }
        }
    }
}
//2简单选择排序
void Selectsort(Sqlist *L)
{
    int i,j,min;
    for(i=1;i<L->length;i++)//在序列中找到最小值放在首位
    {
        min = i;//将最小的游标放在i上
        for(j=i+1; j<=L->length; j++)
        {//对j进行循环，如果发现下标为j的值比下标为min的值小，将min游标指向当前的j
            if(L->r[min]>L->r[j]) min = j;
        }
        if(i!=min) swap(L,i,min);//如果对j进行循环后，发现min不在i上，
    }//也就是说发现了序列中最小的值，将他放在当前的i上序列
}
//3插入排序-->插入排序算法的一种
//有一定的误导性，这就是从头开始，
//比较第一个与第二个，第二个小就进行交换，
//第二个大就接着比较第二个和第三个以此类推，知道比较到倒数第二个和最后一个结束
//只不过这个temp的元素在顺序表上而已
void Insertsort(Sqlist *L)
{
    int i,j;
    for(i=2; i<=L->length; i++)
    {
        if(L->r[i]<L->r[i-1])
        {
            L->r[0] = L->r[i];
            for(j=i-1;L->r[j]>L->r[0];j--)
            {
                L->r[j+1] = L->r[j];
            }
            L->r[j+1] = L->r[0];
        }
    }
}

//希尔排序
void Shellsort(Sqlist *L)
{
    int i,j,k=0;
    int increment = L->length;
    do
    {
        increment = increment/4 + 1;
        for(i=increment+1; i<=L->length; i++)                            //|
        {                                                                //|
            if(L->r[i] < L->r[i-increment])                              //|           
            {                                                            //|这段是插入排序
                L->r[0] = L->r[i];                                       //|
                for(j=i-increment; j>0 && L->r[0]<L->r[j]; j-=increment) //|
                {                                    //j = j-increment   //|
                    L->r[j+increment] = L->r[j];                         //|
                }                                                        //|
                L->r[j+increment] = L->r[0];                             //|
            }                                                            //|
        }                                                                //|
        // printf("%d: ", ++k); print(*L);  for debug
    } while (increment>1);
    
}
//原理明白，但细节不知道TODO
//将顺序表转化为大顶堆
void HeapAdjust(Sqlist *L, int s, int m)
{
    int temp,j;
    temp = L->r[s];
    for(j=2*s; j<=m; j*=2)//j = j*2
    {
        if(j<m && L->r[j]<L->r[j+1]) ++j;
        if(temp>=L->r[j]) break;
        L->r[s] = L->r[j];
        s=j;
    }
    L->r[s] = temp;
}
//堆排序
void Heapsort(Sqlist *L)
{
    int i;
    for(i=L->length/2; i>0; i--)
    {//将L构造成大顶堆
        HeapAdjust(L,i,L->length);
    }
    for(i=L->length; i>1; i--)
    {//交换根节点和最后一个节点，并将L进行调整
        swap(L,1,i);
        HeapAdjust(L,1,i-1);
    }
}
//归并排序
/****************************************************/
void Merge(int SR[], int TR[], int i, int m, int n)
{
    int j,k,l;
    for(j=m+1,k=i; i<=m && j<=n; k++)
    {
        if(SR[i]<SR[j]) TR[k] = SR[i++];
        else TR[k] = SR[j++];
    }
    if(i<=m)
    {
        for(l=0;l<=m-i;l++)
        {
            TR[k+l] = SR[i+l];
        }
    }
    if(j<=n)
    {
        for(l=0;l<=n-j;l++)
        {
            TR[k+l] = SR[j+l];
        }
    }
}

void Msort(int SR[], int TR1[], int s, int t)
{
    int m;
    int TR2[MAXSIZE+1];
    if(s==t)
    {
        TR1[s] = SR[s];
    }
    else 
    {
        m = (s+t)/2;
        Msort(SR, TR2, s, m);
        Msort(SR, TR2, m+1, t);
        Merge(TR2, TR1, s, m, t);
    }
}
//递归法的归并排序
void Mergesort(Sqlist *L)
{
    Msort(L->r,L->r,1,L->length);
}

void Mergepass(int SR[], int TR[],int s, int n)
{
    int i = 1;
    int j;
    while(i<=(n - 2*s + 1))
    {
        Merge(SR, TR, i, i+s-1, i+2*s-1);
        i = i+2*s;
    }
    if(i<n-s+1)
    {
        Merge(SR, TR, i, i+s-1, n);
    }
    else
    {
        for(j=i; j<=n; j++)
        {
            TR[j] = SR[j];
        }
    }
}

void HMergesort(Sqlist *L)
{
    int * TR = (int *)malloc(L->length * sizeof(int));
    int k = 1;
    while(k<L->length)
    {
        Mergepass(L->r,TR,k,L->length);
        k = 2*k;
        Mergepass(TR,L->r,k,L->length);
        k = 2*k;
    }
}
/****************************************************/

//快速排序
/****************************************************/
int Partition(Sqlist *L, int low, int high)
{
    int pivotkey;
    pivotkey = L->r[low];
    while(low<high)
    {
        while(low<high && L->r[high]>=pivotkey)
        {
            high--;
        }
        swap(L,low,high);
        while(low<high && L->r[low]<=pivotkey)
        {
            low++;
        }
        swap(L,low,high);
    }
    return low;
}

void Qsort(Sqlist *L, int low, int high)
{
    int pivot;
    if(low<high)
    {
        pivot = Partition(L, low, high);
        Qsort(L, low, pivot-1);
        Qsort(L, pivot+1, high);
    }
}
void Quicksort(Sqlist *L)
{
    Qsort(L, 1, L->length);
}
/****************************************************/
int HPartition(Sqlist *L, int low, int high)
{
    int pivotkey;
    int m = low + (high-low)/2;
    if(L->r[low]>L->r[high]) swap(L, low, high);
    if(L->r[m]>L->r[high]) swap(L, high, m);
    if(L->r[m]>L->r[low]) swap(L,m,low);

    pivotkey = L->r[low];
    L->r[0] = pivotkey;
    while(low<high)
    {
        while (low<high && L->r[high]>=pivotkey)
        {
            high--;
        }
        L->r[low] = L->r[high];
        while(low<high && L->r[low]<=pivotkey)
        {
            low++;
        }
        L->r[high] = L->r[low];
    }
    L->r[low] = L->r[0];
    return low;
}
#define MAX_LENGTH_INSERT_SORT 7 /* 用于快速排序时判断是否选用插入排序阙值 */
void HQsort(Sqlist *L, int low, int high)
{
    int pivot;
    if((high-low)>MAX_LENGTH_INSERT_SORT)
    {
        while (low<high)
        {
            pivot = HPartition(L, low, high);
            Qsort(L, low, pivot-1);
            low = pivot+1;
        }
    }
    else
    {
        Insertsort(L);
    }
}

void HQuicksort(Sqlist *L)
{
    HQsort(L, 1, L->length);
}
void main()
{   
    Sqlist L;
    generateL(&L);
    HQuicksort(&L);
    print(L);
}