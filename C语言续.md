### 函数指针数组

```c
int jia(int a,int b)
{
    return a+b;
}
int jian(int a,int b)
{
    return a-b;
}
int cheng(int a,int b)
{
    return a*b;
}
int yu(int a,int b)
{
    return a/b;
}
int yu(int a,int b)
{
    return a%b;
}


void main()
{
    //int(*p)(int a,intb);定义函数指针
    //函数指针不仅有类型，还有参数
    //法1
    //int(*p[5])(int a,intb);//定义一个函数指针数组
    //p[0] = jia;
    //p[1] = jian;
    //p[2] = cheng;
    //p[3] = chu;
    //p[4] = yu;
    //法2
    int(*p[5])(int a,int b) = {jia,jian, cheng, chu, yu};
    int x = 100,y = 20;
    for(int i=0;i<5;i++)
    {
    	printf("\n%p",p[i]);
        printf("\n%d",p[i](x,y));
    }
}
```

函数指针的内存原理

函数被载入内存，函数必然有一个地址是函数的入口，若定义一个函数run（），run是一个常量

那么run ，&run，*run都是地址

函数指针不可以使用sizeof





```c
一个指向整型数的指针
int a;
int *p;//指向整数的指针
int **p;//指向（指向整数的指针）的指针

int a[10];//定义一个数组
int *p;//定义一个指针
int *p[10]；一个数组，每一个元素都是指向整数的指针

int a[10];
int *p=a;//

int a[5][10];
int (*p)[10];//一个指向有是个元素的数组的指针


int add(int a)
int (*p)(int a)//一个指向函数的指针
int (*P[10])(int a)//一个数组，其元素是指向函数的指针
```

```c
#include<stdio.h>
#include<stdlib.h>

char str1[20] = "notepad";
char str2[20] = "tasklist";
//在函数里面改变一个外部变量，就需要变量的地址
//如果是数据，需要指向数据的指针存储数据的地址
//如果是指针，就粗腰指向指针的指针存储指针的地址
//二级指针一般用于改变一个字符串指针的指向，指向不同的字符串	
void change(char *str)//函数有副本机制，形式参数会开辟内存，新建变量
{
	printf("%p",&str)
    str = str1;
    
}
void changep(char **pp)//改变一个变量，需要变量的地址，如果变量是指针就需要二级指针
{
	//*pp就是字符串指针类型，char *
    *pp = str1;
}
void main()
{
    char *p = str2;
    changep(&p);//改变p需要p的地址
    printf("%p",&p)
    //change(p);
    system(p);
}
```



```c
#include<stdio.h>
#include<stdlib.h>

#define DB double
typedef double db;

#define DP double *
typedef double* dp;

#define 给老子跑起来 main//使用与所有替换
//typedef main 给老子跑起来//只适用于已有的数据类型

void 给老子跑起来()
{
    DB d1 = 1.2,d2 = 1.8;//替换，
    db d3 = 1.9,d4 = 2.3;//别名，
    printf("%f,%f",d1,d2);
    printf("%f,%f",d3,d4);
	
	DP dp1,dp2;//double *dp1,dp2,dp1是指针四个字节，dp2是浮点数，八个字节
	dp dp3,dp4;//double *dp3,dp4,都是四个字节的指针，
    printf("%d,%d,sizeof(d1),sizeof(d2));
    printf("%d,%d",sizeof(d3),sizeof(d4));
	
	system("pause");    
}
```

  字符串指针以及数组

```
void main()
{
	char *p = "tasklist";
	printf("%d",sizeof(p));//输出4
	printf("%d",sizeof("tasklist"));//输出9
	//p存储的是常量字符串“tasklist”的首地址
	//*p = '1';tasklist 是一个常量，无法赋值
    system("pause");
}


void main()
{
    char *p = "tasklist";
    systm(p);
    char *p[10] = {"tasklist",
    			   "calc",
    			   "write",
    			   "mspaint",
    			   "notepad",
    			   "color 3d",
    			   "title china",
    			   "ipconfig",
    			   "mstsc",
    			   "echo chiona is great"};
     printf("%d",sizeof(p)/sizeof(char *));//输出10
    for(int i=0;i<10;i++)
    {
        printf("\n%s",p[i]);
        system(p[i]);
        
    }
}
```

 