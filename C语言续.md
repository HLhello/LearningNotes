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