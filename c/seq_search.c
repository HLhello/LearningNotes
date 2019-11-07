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
void fab()
{
    Fib[0] = 0;
    Fib[1] = 1;
    for(int i=0;i<100;i++)
    {
        Fib[i] = Fib[i-1]+Fib[i-2];
    }
}
//无哨兵
int Sequential_search1(int *a, int n, int key)
{
    for(int i=0;i<n;i++)//这个的缺点是在每次都要与n比价，增加计算量
    {
        if(a[i]==key)
        {
            return i;
        }
    }
    return 0;
}
//有哨兵
//若找到，返回key在数列中的下标值
//若没找到，返回-1
int Sequential_search2(int *a, int n, int key)
{
    //这个if判断是我自己加的，那如果a[0]==key怎么办？
     int temp = a[0];
    if(a[0] != key) a[0] = key;//这样不是把数组值给改变了么？不太好吧
    else return 0;

    int i=n-1;
    while(a[i]!=key)//增加一个哨兵值后，只要找到key就返回其在数组中下标的值
    {
        i--;
    }
    a[0] = temp;//将数组恢复原样
    if(i==0) return -1;//如果没找到返回-1
    else return i;
}
//二分法查找以及插值查找必须是有序的序列
int Binary_search(int*a, int n, int key)
{
    int low, mid, high;
    low=0;
    high = n-1;
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
    return -1;
}
//插值查找，就是改变了二分法的系数
int Insert_search(int *a,int n,int key)
{
    int low, mid, high;
    low=0;
    high = n-1;
    if(key<a[low] || key>a[high]) return -1;
    while(low <= high)
    {//有点问题，a[low]或a[high]不再数组中就有可能出问题
        mid=low + (high-low)*(key-a[low])/(a[high]-a[low]);
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
    return -1;
}

void main()
{
    int a[100],x;
    for(int i=0;i<100;i++)
    {
        a[i] = i+1;
    }
    //a[0] = 101;
    for(int i=0;i<100;i++)
    {
        printf("%d ",a[i]);
    }
    x = Insert_search(a,100,100);
    printf("\n%d",x);
}

// int Fib_search(int *a,int n,int key)
// {
// 	int low,high,mid,i,k=0;
// 	low=1;	/* 定义最低下标为记录首位 */
// 	high=n;	/* 定义最高下标为记录末位 */
// 	while(n>Fib[k]-1)
// 		k++;
// 	for (i=n;i<Fib[k]-1;i++)
// 		a[i]=a[n];
// 	while(low<=high)
// 	{
// 		mid=low+Fib[k-1]-1;
// 		if (key<a[mid])
// 		{
// 			high=mid-1;		
// 			k=k-1;
// 		}
// 		else if (key>a[mid])
// 		{
// 			low=mid+1;		
// 			k=k-2;
// 		}
// 		else
// 		{
// 			if (mid<=n)
// 				return mid;		/* 若相等则说明mid即为查找到的位置 */
// 			else 
// 				return n;
// 		}
		
// 	}
// 	return 0;
// }
//也是改变了分开的系数，利用黄金分割
// int Fib_search(int *a, int n, int key)
// {
//     int low, mid, high;
//     low=1;
//     high = n;
//     int k = 0;
//     //Fib 为计算好的斐波那契额数列
//     while(n>Fib[k]-1)//这里为啥要-1呢？
//     {
//         k++;
//     }
//     for(int i=n;i<Fib[k]-1;i++)
//     {
//         a[i] = a[n];//将查找数组少的部分补全
//     }
//     while(low <= high)
//     {
//         mid=low+ Fib[k-1]-1;
//         if(key<a[mid])
//         {
//             high = mid-1;
//             k = k-1;
//         }
//         else if(key>a[mid])
//         {
//             low = mid+1;
//             k = k-2;
//         }
//         else 
//         {
//             if(mid<=n) return  mid;
//             else return n;
//         }
//     }
//     return 0;
// }
