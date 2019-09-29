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

 ### 函数高级

函数副本机制

```c
//在编译一次，TODO
#include<stdio.h>
#include<stdlib.h>
void change(int num)
{
	num = 8;
	printf("\nchange num = %d", num);
	printf("\nchange = %p", &num);
}

void changep(int *num)
{
	* num = 7;
	printf("\nchangep num = %d", num);
	printf("\nchangep = %p", &num);
}
void main()
{
	int num = 10;
	printf("\nnum = %d", num);//输出10
	printf("\nmain = %p", &num);

	num = 9;
	printf("\nnum = %d", num);//输出9
	printf("\nmain = %p", &num);
	
	change(num);
	printf("\nnum = %d", num);//输出为多少？
	
	changep(&num);
	printf("\nnum = %d", num);//输出为多少？    
	
	system("pause");
}
```

  指针也有副本机制

无论传递什么参数，函数都有副本机制

改变一个变量，需要传入变量的地址

改变一个指针变量，需要指针变量的地址

### 结构体数组组作为函数参数

```c
#include<stdio.h>
#include<stdlib.h>
struct csdn
{
	char user[40];
	char passward[40];
	char email[40];

};


// void find(struct csdn cdata[5], char *str) 
void find(struct csdn *cdata[5], char *str)
{
	printf("\nfind中cdata占%d个字节",sizeof(cdata));
	for (int i = 0; i<5; i++)
	{
		if (strcmp(cdata[i].user, str) == 0)
		{
			printf("\n找到 %s, %s, %s", cdata[i].user, cdata[i].passward, cdata[i].email);
		}
		else
		{
			printf("\nnot find");
		}
	}

}


void main()
{
	struct csdn cdata[5] = { { "hello", "1945452344", "asdfasweedf@qq.com" },
	{ "hasdflo", "194542454", "asdfasdddtf@qq.com" },
	{ "hxcvlo", "19454567754", "asdfajklhsdf@qq.com" },
	{ "hewelo", "1941215454", "asdertfasdf@qq.com" },
	{ "hsdllo", "1945456784", "dfasdf@qq.com" } };
	for (int i = 0; i<5; i++)
	{
		printf("%s %s %s\n", cdata[i].user, cdata[i].passward, cdata[i].email);

	}
	printf("\ncdata占%d个字节",sizeof(cdata));
	printf("\nstruct csdn占%d个字节",sizeof(struct csdn));
	printf("\n\n\n");
	find(cdata, "hewelo");
	system("pause");
}
```



 return局部变量

```c
#include<stdio.h>
#include<stdlib.h>

//函数的参数，函数内部定义的局部变量，函数执行完成的时候，就会被操作系统回收
//内存会被其他程序所用
void go(int num)
{
    int x = 10;
    printf("\nnum = %d,x = %d",num,x);
    printf("\n&num = %p,&x = %p",&num,&x);
    
}
void main()
{
	go(3);
	printf("hello");
    system("pause");
}
```

return副本机制

```c
//函数的参数，还有定义的临时变量，函数执行完成之后都会被函数回收给其他函数用
//函数的返回值有副本机制，也就是编译器自动将返回值赋值一份，所以即使函数运行完成，即使函数运行完成，函数变量回收，值仍然正确
int sum(int a,int b)
{
    int c = a+b;
    priontf("%d,%p",c,&c);
    return c;
}
void main()
{
    int num = sum(1,2);
    printf("%d",num); 
    
}
```

函数返回值声明周期

```c
#include<stdio.h>
#include<stdllib.h>
int add(int a,int b)
{
    int z = a+b;
    return z;//插入断点
}
int print(int num)
{
    printf("%p",&num)
    return num;
}
//如果返回全局变量，变量会一直存在   
void main()
{
    printf("%d",add(1,2));//为什么返回值已经被销毁，还能输出
    //这是由于返回值的副本机制，返回的时候，另外在保存一份，
    //插入断点
    printf("%d",print(188));
    printf("\n\n");
    printf
}
```





跨函数使用内存

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
//不要返回指向栈内存的指针
//栈返回的时候内容会被清除
//凡是没有用到malloc并且在函数内部定义分配数组或者变量都是栈
char *getmum()
{
	char str[100] = "123456789";
	//栈上，系统自动分配自动回收
	//函数调用的时候分配，函数结束的时候回收
    char *p = str;//存储数组的首地址
	//插入断点
    return  p;
}

void main()
{
	char *pstr = NULL;//定义一个空指针
    //插入断点
	pstr = getmum();//获取内存的首地址
	//插入断点
    if (pstr != NULL)
	{
        //插入断点
		strcpy(pstr, "hello world");//拷贝成功了
        //插入断点
		printf("%s", pstr);//调用printf的时候内存被自动回收了，所以无法显示
        //插入断点
	}
	system("pause");
}
```

关于栈和堆的理解

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

char *getmum()
{
	//动态分配的内存只有自己能回收
	char *p = (char *)malloc(100);//指针转换
    for(int i=0;i<100;i++)//对内存实现清零
    {
        p[i] = 0;
    }

	return  p;
}
void main()
{
	char *pstr = NULL;
	//插入断点
	pstr = getmum();//
	//插入断点
	if (pstr != NULL)
	{
		//插入断点
		strcpy(pstr, "hello world");//
		//插入断点
		printf("%s", pstr);//
		//插入断点
	}
    free(pstr);//回收内存
	system("pause");

}
```

只读存储区

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
void main()
{
	char*p = "hello china";//定义一个指针，存储只读存储区字符转的地址
	printf("%d,%d",sizeof(p),sizeof("hello china"));//输出失身么
	//*p='A';只读存储区只能读不能写
	system("pause");
}
char * getmum()
{
	//这片内存在静态存储区，不会被回收
	//p会被回收
    char *p = "hello china,hello hello";
    printf("%p", p);
    //return有副本机制
    return p;
}
void main()
{
    char *pstr = getmum()
    printf("%s",pstr);
    //*pstr='A';只读存储区不能输入
    system("pause");
}
```

函数返回的指针不能指向栈内存

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int* go()
{
    int a = 10;//a在栈上
    printf("%p",&a);
    int *p = &a;
    return p;
}
void main()
{
	int *px = go();//获取指针
	printf("%d",*px);//输出数值
	printf("\n");//栈自动回收利用了内存
	printf("%d",*px);//不能正确输出
	system("pause");
}
int* goN()
{
    int a[5] = {1,2,3,4,5};//a在栈上
    printf("%p",&a);
    int *p = &a;
    return p;
}
void main()
{
	int *px= goN();
    for(int i = 0;i<5;i++)
    {
        printf("%d",*(px+i));
    }
    system("pause");
}
```

函数返回值应该指向堆

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
char *getccc()
{
	char *p = (char*)malloc(1);
	printf("%p\n", p);
	*p = 'A';
	return p;
}
void main()
{
	char *pch = getccc();
	printf("\n");
	printf("%c", *pch);
    free(pch);
	system("pause");
}
char *getccc1()
{
	char *p = (char*)malloc(10);
	printf("%p\n", p);
	for(int i = 0,num = 65;i<10;i++,num++)
    {
        p[i] = num;//给每个字符赋值
    }
	return p;
}

void main()
{
	char *pch = getccc1();
	for(int i=0;i<10;i++)
    {
        printf("%c",pch[i]);
    }
    free(pch);
	system("pause");
}
```

 指向堆的数组

```c
//堆可以跨函数使用
//除非自己释放，否则永远占用
int *getint()
{
    int *p = NULL;
    p = (int *)malloc(sizeof(int)*10);
    for(int i=0;i<10;i++)
    {
        p[i] = i;
    }
    return p;
}

void main()
{
    int *p = getint();
    for(int i=0;i<10;i++)
    {
        printf("%d",p[i]);
    }
    free(p); 
}
```

结构体作为函数参数

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
struct info
{
	char name[50];
	long long phone;
};
//函数的副本机制，函数的参数新建了一个变量接受meinv的值
//info1的改变不影响美女
void showinfo(struct info info1)
{
	strcpy(info1.name, "hailou");
	printf("\n%s,%d", info1.name, info1.phone);

}
//函数的副本机制，所以改变一个外部变量，需要变量的地址 
void changeinfo(struct info *p)
{

	strcpy(p->name, "HL");
	printf("\n%s,%d", p->name, p->phone);

}
void main()
{
	struct info meinv = { "hello", 13899887766 };
	printf("%s,%d", meinv.name, meinv.phone);
	changeinfo(&meinv);
	system("pause");

}
```

对于结构体，内容很少可以传值，内容很多，最好传址，

函数改变一个结构体，需要传递结构体的地址

结构体变量的成员可以被当做普通变量来处理

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
struct zhanghu
{
	int num;
	int data;
}; 
void change(int a, int b)
{
	a = 9, b = 100;
}
void changep(int *a, int *b)
{
	*a = 9, *b = 100;
}
void main()
{
	struct zhanghu zh1 = { 1, 100 };
	printf("%d,%d", zh1.num, zh1.data);
	//change(zh1.num, zh1.data);
	changep(&zh1.num, &zh1.data); 
		printf("%d,%d", zh1.num, zh1.data);
	system("pause");
}
```



返回值为结构体

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
struct info
{
	char name[50];
	int num;
};
struct info getstruct(char *p, int num)
{
	struct info info1;//创建结构体，临时中间变量，栈区，函数调用完后被回收
	info1.num = num;
	strcpy(info1.name, p);
	return info1;//return副本机制，在调用函数后能返回，但是函数调用结束，程序执行里一个操作，内存就会被释放
}
//指针返回的时候，不能返回指向栈区的内存
struct info * getstructp(char *p, int num)
{
	struct info info1;//
	info1.num = num;
	strcpy(info1.name, p);
	return &info1;//
}
struct info * getstructpm(char *p, int num)
{
	struct info *pinfo = (struct info*)malloc(sizeof(struct info));
	pinfo->num = num;
	strcpy(pinfo->name, p);
	return pinfo;
}

void main()
{
	//struct info mm = getstruct("hello china", 10);
	//struct info * mm = getstructp("hello china", 10);
	struct info * mm = getstructpm("hello china", 10);
	printf("%d,%s", mm->num, mm->name);
	system("pause");
}
```

指针数组作为函数参数

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
void runandprint(char *command[])
{
	
	for (int i = 0; i<5; i++)
	{
		printf("\n%s", command[i]);
		system(command[i]);
	}
//printf("sizeof(command) = %d", sizeof(command));
}
void main()
{
	char *cmd[] = { "calc", "notepad", "tasklist", "ipconfig", "mspaint" };
	printf(sizeof(cmd));//20个字节。每个指针四个字节
	runandprint(cmd);
	system("pause");
}
```

递归的讨论

```c
#include<stdio.h>
#include<stdlib.h>
double go(int n)
{
	if (n == 1)
	{
		return 1.0;
	}
	else if (n == 2)
	{
		return 2.0;
	}
	else
	{
		return go(n - 1) + go(n - 2);
	}

}

void main()
{
	printf("%f", go(10));
	double a[50];
	a[0] = 1;
	a[1] = 2;
	for (int i = 2; i<10; i++)
	{
		a[i] = a[i - 1] + a[i - 2];
		printf("\n%f", a[i]);
	}
	system("pause");
}
```

判断数组是否递增

```c
void main()
{
    int a[10] = {1,2,3,4,5,6,7,8,9,10};
    int flag = 1;
    for(int i = 0;i<10;i++)
    {
        if(a[i]>a[i+1])
        {
            flag = 0;
            break;
        }
    }
    if(flag == 0)
    {
        printf("biger");
    }
    else
    (
    printf("not biger"));
}
```



```c
//判断数组是否是递增的
#include<stdio.h>
#include<stdlib.h>
int a[10] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
int isbiger(int n)//递增返回1，非递增返回0
{
	if (n == 8)
	{
		return a[n]<a[n + 1];
	}
	else
	{
		return (a[n] < a[n + 1]) && isbiger(n + 1);
	}
}

void main()
{
	printf("%d", isbiger(0));
	system("pause");
}
```



```c
void main()
{
    int num;
    scanf("%d",num);
    printf("num = %d",num);
    int lastres = 0;
    while(num)//num == 0时终止
    {
        lastres *=10;
        int wei = num%10;
        lastres = wei*10;
        ;astres+= wei;
        num /=10;
        
    }
}
```

递归的要素

```c
//终止条件
//循环要素，递进机制
#include<stdio.h>
#include<stdlib.h>
int go(int n)
{
    if(n==1)
    {
        return 1;//循环终止条件
    }
    else
    {
        return n*go(n-1);
    }
}


void main()
{
	printf("%d",go(5));
    system("pause");
}
```

汉诺塔

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
int go(int n)
{
	if (n == 1)
	{
		return 1;
	}
	else
	{
		return 2 * go(n - 1) + 1;
	}
}
void honi(int n, char A, char B, char C)
{
	if (n == 1)
	{
		printf("\n%c->%c", A, C);
	}
	else
	{
		honi(n - 1, A, C, B);//确定谁是辅助盘
		printf("\n%c->%c", A, C);
		honi(n - 1, B, A, C);
	}
}
void main()
{
	int n;
	scanf("%d", &n);
	int times = go(n);
	printf("\n%d", times);
	honi(n, 'A', 'B', 'C');
	system("pause");
}
```

循环的效率更好一些，省去了函数调用的时间

但是递归能实现的，循环不一定能实现，循环能实现的，递归不一定能实现

为了速度，尽量使用循环

为了间接，最好使用递归

```c
#include<Windows.h>
HWND win;//寻找窗口名
void opentaobao()
{
	//打开淘宝
    ShellExecuteA(0,"open","path\\taobao.exe",0,0,1);
}
void closetaobao()
{
	//关闭淘宝
    system("taskkill /f /im 进程名");
}
void playedtaobao()
{
    win = FinWindowA("窗口类型"，"窗口名");
    if(win == NULL)
    {
        printf("找不到")；
    }
    SetwindowTextA(win,"找不到")； 
}
void main()
{
    opentaobo();
    
    closetaobo();
}
```

  函输小结

 C语言函输参数传递有传值和传址两种参数

改变一个变量，需要变量的地址

函输返回同样有值和地址之分，但应该注意不要返回直线局部变量，也就是栈内存的指针

数是C语言的核心

作为两种有效组织数据集的手段，结构和数组在函数中有着广泛的应用，结构体变量本质上可以当成是普通变量来使用

函数实现时，是通过栈来实现的 

编译时先整体读取代码，结束时就已经到达函数尾部，然后把每个操作压入栈中，最后按照顺序执行，依次出栈

```
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
//传递一个数组，对数组进行排序
int * sort(int *p,int n)
{
	for (int i = 0; i<n - 1; i++)
	{
		for (int j = 0; j<n-1-i; j++)
		{
			if (p[j]<p[j+1])
			{
				int temp = p[j];
				p[j] = p[j+1];
				p[j+1] = temp; 
			}
		}
	}
	return p;
}
void main()
{
	int a[10] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
	int num = sizeof(a) / sizeof(int);
	int *p = sort(a, num);
	for (int i = 0; i < num; i++)
	{
		printf("%d,%d\n", a[i],p[i]);

	}
	system("pause");
}
```

生存期，作用域，可见域

```c
//C语言编译时从上到下编译，所以要用必须要提前声明

#include<stdio.h>
extern int x;//提前声明
void pt();
void main()
{
    pt();
    printf("%d",x);
    system("pause");
}
int x = 10;
void pt()
{
    printf("hello");
}
```

内存，变量名函数名等都对应着内存中的一块取余，这些实体是如何存放的呢？

内存分配的原理

```c
//数据代码都会被在如内存，内存单元都有地址
//数组名就是数组的搜地址，函数名就是函数二进制代码块的入口点地址
void move()
{
    printf("move");
}
void main()
{
	int a[5] = {1,2,3,4,5};
    printf("%p",a);
    printf("%p",move);//输出程序入口点在内存中的位置
    system("pause");
}
```

变量的存储有四种类型

auto（自动），static（静态），extern（外部），register（寄存器），分别放在不同的内存区域

全局变量与局部变量比较

```c
void go(int num)
{
    //printf("%d",a);前面没有定义，就不能编译
    num = 11;
    int a = 10;
    printf("%d",a);
    printf("%d",num);
}
void main()
{
	//printf("%d",a);//a就是局部变量，a的作用范围就是在go函数定义之下 
    system("pause");
} 
```

局部变量一般定义在函数内部，在函数被调用的时候才分配内存，

函数调用结束，内存被释放

不同函数之间，可以定义相同名字的变量

 全局变量，作用域从定义开始到函数结束

全局变量一经定义一直存在到程序结束

全局变量在定义后编译器会为他分配一段内存

某个函数修改了全局变量，其他函数读取时就是新值

生存期程序在执行的过程中，变量从生成到撤销的一段时间

自动分配就是在栈上，系统自动回收清理

函数调用的时候，从定义的地方开始创建

函数结束的时候系统自动进行回收

对于自动分配（栈分配）变量与其所在的代码块共存亡

对弈静态分配（编译器分配）变量与程序共存亡，程序开始执行时就存在，程序运行完毕退出后撤销

关于静态分配

关于动态分配

malloc，动态分配的内存函数

使用malloc分配的内存的变量，在堆上，程序员可以自己分配合回收

作用域可见域比较

可见域是可以合法访问的，比如在代码块内定义了重名变量，代码块之外的变量会被屏蔽

块语句结束的时候，内部的局部变量都会被自动回收

跨文件使用，结合extern可以跨文件使用

如果需要跨文件使用的变量定义时定义成static变量，那么就不能跨文件使用，即使声明时是用extern

变量定义的三个地方

第一函数外面，全局变量

第二函数的参数，局部变量

第三函数内部，局部变量

生存期，自动分配，系统分配，动态分配

作用域可见域的区别，块语句的屏蔽，生存期重合的不同函数的局部变量

了解变量定义的三个地方

auto变量，是C语言应用最广的一种变量，这类变量是栈分配的，是动态分配存储空间的，比如说函数的形参，在函数调用时才分配内存，函数调用结束自动回收

一般情况下，在函数内部，块语句内存定义的变量都会被编译器自动解析成自动变量

关于auto变量的初始化

在使用变量时一定要初始化



寄存器变量

寄存器在cpu内部运算速度非常快

内存的数据必须载入寄存器才能计算

地址对应得内存地址，在寄存器中没有地址

```c
#include<stdio.h>

void main()
{
    time_t start, end;
    time(&start);
    sleep(3000);
    time(&end);
    printf("%d",(unsigned int)(end-start));
}
```

有的编译器会自动将使用频繁的变量自动转换成register，有的就不会

我们需要把频繁使用的变量声明成寄存器型的变量

寄存器说明符只能用于说明函数中的变量和函数中的形参

不允许将全局变量或者静态变量说明为register

静态变量不允许声明为寄存器型





extern变量

又称为全局变量，放在静态存储区，整个程序中都可以使用

extern有定义和声明之分

```c
file 1 ！！
#include<stdio.h>
#include"file2.c"
int x = 10;//全局变量，编译器会自动解析成extern int x = 10
//可以被程序其他函数引用，不仅仅局限在本文件
void go()
{
    printf("%d",x);
}
void main()
{
    printf();
}
file 2 ！！
extern int num;//声明全局变量num的存在
void print()
{
    printf("%d",x);    
}

```

全局变量声明与定义

```c
void main()
{
    //int num;
    //int num = 1;
    //上述变量是自动变量，都是定义，同一个快语句不允许重定义
}
对比
i#include<stdio.h>
int num ;
int num = 1;
//函数可以有多个声明，全局变量也可以多个声明
//函数只能有一个定义，全局变量也只能有一个定义
//int num = 10;
//变量重定义，创建一个变量并且赋值就是定义
//没有赋值就是声明
//允许重复声明不能重复定义
//类比于函数的定义 
void main()
{
    
}
```

全局变量定义的基本格式

extern 类型 变量名 = 初始化表达式

省略extern，初始表达式可以省略，编译器会将该全局变量初始化为0

初始化表达式不能省略，此指令通知编译器在静态存储区中开辟一块指定类型大小的内存区域，用于存储该变量

只要在外部，就是全局变量，无论有没有extern

只声明不定义在程序中使用该全局变量时，会报错：一个无法解析的外部符号





小结

全局变量都在函数外部，有声明和定义之分

全局变量如果赋初值，就是定义，没赋初值就是声明，声明可以有多个，第一只能有一个

使用extern全局声明

```c
void print()//函数的声明，让编译器知道函数的存在
extern int x;//也可以放在最前面
void main()
{
	extern int x;//外部声明，在使用之前先声明
    printf("%d",x);
    
}
int x = 10;//定义一个全局变量
void print()
{
    printf("hello sky")
}
```

跨文件使用全局变量，在需要使用的文件中提前使用extern声明，extern也可以省略，函数外部编译器一般都会自动添加extern

 全局变量的作用域是理论上的范围，也就是程序的任何部分，无论程序有几分c文件，作用域在任何地方，需要声明，没有合理的声明就无法使用

特定位置，是否可见，取决于是否合理进行声明

可见域就是实际上客以使用的区域  

注意局部变量屏蔽全局变量

全局变量的好处与坏处

需要两个函数操作一个变量，就需要全局变量

  可以有效减少参数，

坏处

全局变量一直占用程序内存，过多会造成程序运行变慢

程序可读性下降，程序移植比较麻烦

函数之间耦合性变高

理解如何跨文件使用方法





static变量

static有静态局部变量和静态全局变量之分

extern没有局部变量，使用extern不能定义在函数体语句块中

在块语句中定义的局部变量，每次块语句结束，就自动回收，然后重新分配

内次值都是0

静态局部变量始终在内存，一旦定义初始化，即使再次执行初始化语句，也仅仅只执行一次初始化，声明周期一直会占据内存，与程序共存亡

静态局部变量的作用域是当前的块语句

静态局部变量的用途

静态的局部变量让代码的移植性更强

在使用递归时，有可能无法查看中间变量，使用static可以查看中间结果

static可以保留块语句中间的结果

对于静态局部变量来说没有声明只有定义

静态全局变量

```c
staic int num = 10;
extern int data = 0;
void main()
{
    printf("%d",num);
    printf("%d",data);
}
同一个c文件可以使用静态全局变量，但是不可以在另一个文件中引用
```

静态局部变量没有声明与定义的区别， 无论是否有初值，都是定义

静态全局变量可以有很多声明，但只能有一个定义

省略初始化的表达式，静态变量会自动初始化为0

如果静态全局变量有多个声明而没有定义，编译器会把最后一个初始化为0

static函数

限定函数可以应用的范围



调用外部函数一般需要外部声明

内部函数声明不用加extern，外部函数声明需要加extern

 使用频繁的函数会打包声明在头文件中比如stdio.h,stdlib.h等等

一般的函数作用域是整个项目任何地方都可以引用

一般的函数的可见域，如果是外部函数，c文件都可以直接引用，内部函数从定义的地方知道函数结束

如果要在凹函数定义之前引用，增减函数的声明，扩大可见域

限定函数仅仅作用于本文件，使用static关键字，     





结构体定义的作用域与可见域

 结构体变量作为局部变量没有定义与声明的区别

机构体变量作为全局变量有定义与声明的区别

作用域理论上可以调用的范围

可见域，就是实际上可以调用的范围

不同的源文件引用外部结构体变量，不仅需要外部声明还需要结构体定义

结构体类型最多能使用与一个c文件，

不同的c文件可以包含同名同类型的结构体变量类型

也可以包含同名不同类型的结构体类型

同一源文件，只能有一个，只要作用域不同就可以重复定义同名同类型

同一作用域，同名同类型的只能有一个定义

同名不同类型的也只能有一个





静态区，代码区，堆区，栈区

全局变量在静态区存储，

栈区系统自动分配内存，堆区自己分配

静态区与程序共存亡

代码区与程序共存亡

栈区程序调用时分配，结束时回收

堆区自己决定开始，自己决定回收

作用域可见域

作用域理论上可以访问的区域

可见域就是你得先能看到这个变量你才能使用，如果你都看不到，也就无法使用

形参可以是寄存器型和自动型 





变量命名的规则

 见名知意，   

assert宏

```c
#define NDEBUG//关闭静态断言，只能放在最上方
#include<stdio.h>
#include<stdlib.h>
#include<assert.h>// 静态断言的头文件

void main()
{
    double db1,db2;
    scanf("%lf%lf",&db1,&db2);
    printf("db1 = %f,db2 = %f",db1,db2);
    saaert(db2 != 0);
    printf("\ndb1/db2 = %f",db1/db2);
    systen("pause");
    
}
```





预处理命令

```c
#include<stdio.h>
#include<stdlib.h>
#define cn "你好世界"
#define en "hello world"
#define B 1  //可以定义1，也可以定义2,
条件编译是让我们有选择的编译一套代码，这是有选择的编译
实现代码的精简，不符合条件，就不编译
预处理指令必须一行一个
预处理指令以#号开头，	没句最好只占一行，否则会出现编译错误，
预处理可以放在任何位置，习惯放在头部
预处理就是说在对文件进行实质性的编译之前，先处理这些预处理行
void main()
{
    #if B == 1
    	printf(cn);
    #else 
    	printf(en);
    #endif
    
}
```

define就是简单的替换，不检查类型，不检查输入错误，仅仅只是替换

万物皆可使用define替换

define定义常量，如果与定义的变量重名，就会报错

尽量不用define，用const，const初始化的时候，会自动进行类型转换

const是有类型检查的

宏替换的规则

宏替换只能替换单独的标识符，连在一起的无法替换，或者字符串内部的也无法替换

同一个源文件宏不能重名

多个源文件宏可以重名

宏的作用域就是他所在的源文件

 宏定义的嵌套，在预处理时会实现层层替换

```c
#define M 10

。。。
。。。
。。。

#undef M  //限定宏定义的作用域，#define M 10 ----> M结束

```

带参数的宏

```c
#include<stdio.h>
#include<stdlib.h>
		宏名		要替换的字符串
#define ADD(x)   3*x
#define cube(x)  x*x*x
//define可以传入任何参数，这样的作用是节省程序编译的时间
void main()
{
    printf("%d",ADD(3));
    printf("%f",cube(4) );
    system("pause");
}
```

文件包含

 include<>从系统的目录开始搜索

include""从当前的目录开始搜索，也可以指定目录

 一般情况不要包含c源文件

条件编译

让某些代码参与编译，让某些代码不用编译

预编译的工作

文件包含，宏定义，条件编译

代码调试的宏

```c
__DATE__ 进行预处理的日期
__FILE__ 代表当前源代码的字符串文字
__LINE__ 代表当前源代码的行号的整数常量
__TIME__ 代表当前源文件编译时间
__FUNCTION__ 代表当前所在的函数名
```







define与const 的差别

赋值会自动进行类型转换

const是有数据类型的，发现类型不同就会自动进行强制数据转换，并且发出警告

C语言的一种变量是对内存空间的抽象

```c
#include<stdio.h>
#include<stdlib.h>
#define S(x) system(pause)
#define SS(x) sysyem(#x) //自动给参数转换为“x”，转换为字符串 
//C语言中的变量是对内存的一种抽象
#define printfNUM(x) printf("%s = %d",#x,x)


void main()
{
    system("notepad");
    S("calc");
    SS(calc);
    SS(notepad);
    int a1 = 10, a2=20, a3=30;
    printf("a1 = 10",a1,a1);
    //printf("%s = %d",a1,a1);报错
    printfNUM(a1);//输出 a1 = 10;
    
}
```





```C
//宏连接
#include<stdio.h>
#include<stdlib.h>
#define I(x) I##x   //两个##起到连接的作用,把两个标识符粘在一起
#define P(x) printf("%s = %d",#x,x)
void main()
{
    int I(1),I(2),I(3);
    I1 = 111;
    I2 = 222;
    I3 = 333；
    P(I(1));
    P(I(2));
    P(I(3));
    system("pause");
}
```

```c
#include<stdio.h>
#include<stdlib.h>
#define P(x) printf##x
void printf1()
{
    printf("11111");
}
void printf1()
{
    printf("22222");
}
void printf1()
{
    printf("33333");
}
void main()
{
    P(1)();
    system("pause");
      
}
```





const 本质是伪常量，const变量一旦初始化后无法直接赋值

并不是完全只读的，无法直接赋值，可以间接赋值

利用强制转换可以去掉const属性，就可也间接修改const的值 

const变量在栈区，不再静态区只有个栈区会自动回收变量

根据内存中的特点来判断一个变量在不在栈区

静态区不会被反复释放利用

const无法用于数组初始化

```c
#include<stdio.h>
#include<stdlib.h>
void main()
{
    const int num = 10;
    //num = 11;编译不通过const只是限定一个变量无法直接被赋值
    const int *p = &num;//定义一个指针指向一个常量，存储num的地址
    int *pv = (int *)p;//对指向常量的指针进行强制转换
    *pv = 8;//对指针指向的内容进行赋值
    printf("%d",num);//间接的改变了一个常量
    
    system("pause");
}
```





简单链表

```c
#include<stdio.h>
#include<stdlib.h>

struct info
{
    int num;
    void *p;    
};
void main()
{
    //静态模式
    struct info info1;
    info1.num = 123;
    info1.p = &info1.num;//空指针可以存储任何地址
    printf("%d,%p",info1.num,info1.p);
}
```



```
#include<stdio.h>
#include<stdlib.h>

struct info
{
    int num;
    void *p;    
};
void main()
{
    
    struct info *pinfo
    pinfo = (struct info *)malloc(sizeof(struct info));
    //pinfo -> num = 125;
    //pinfo -> p = &pinfo ->num;
    //printf("%d,%p",pinfo->num,pinfo->p);
    (*pinfo).num= 125;//*加上指针就取出了结构体的内容，等价于一个结构体
}
```

