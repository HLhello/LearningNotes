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

typedef int Status;	//Status是函数的类型,其值是函数结果状态代码，如OK等

int Fib[MAXSIZE]; //斐波那契数列

int Sequential_search1(int *a, int n, int key)
{
    for(int i=0;i<n;i++)
    {
        if(a[i]==key)
        {
            return i;
        }
    }
    return 0;
}

int Sequential_search2(int *a, int n, int key)
{
    int i;
    a[0] = key;//这样不是把数组值给改变了么？不太好吧
    i=n;
    while(a[i]!=key)
    {
        i--;
    }
    return i;
}

int Binary_search(int*a, int n, int key)
{
    int low, mid, high;
    low=1;
    high = n;
    while(low <= high)
    {
        mid = (low+high)/2;
        if(key<a[mid])
        {
            high = mid-1;
        }
        else if(key>a[mid])
        {
            low = mid+1;
        }
        else return  mid;
    }
    return 0;
}
int Insert_search(int *a,int n,int key)
{
    int low, mid, high;
    low=1;//不明白为什么要设置成1，并应该是0嘛？这都什么鬼TODO
    high = n;
    while(low <= high)
    {
        mid=low+ (high-low)*(key-a[low])/(a[high]-a[low]);
        if(key<a[mid])
        {
            high = mid-1;
        }
        else if(key>a[mid])
        {
            low = mid+1;
        }
        else return  mid;
    }
    return 0;
}

void main()
{
    int a[100],x;
    for(int i=0;i<100;i++)
    {
        a[i] = i+1;
    }
   for(int i=0;i<100;i++)
    {
        printf("%d ",a[i]);
    }
    x = Insert_search(a,100,5);
    printf("\n%d",x);
}