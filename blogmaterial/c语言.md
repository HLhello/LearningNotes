阅读并理解以下代码

```c
void main()
{
unsigned char a = 97;
printf("%p",&a);
printf("%c,%d\n", a,sizeof(a));
printf("%d,%d\n", a,sizeof(a));
printf("%f,%d\n", a,sizeof(a));

char ch = 'a';
printf("%p", &ch);

printf("%c,%d\n", ch, sizeof(ch));
printf("%d,%d\n", ch, sizeof(ch));
printf("%f,%d\n", ch, sizeof(ch));

int y = 5;
printf("%p", &y);

printf("%c,%d\n", a + y, sizeof(a + y));
printf("%d,%d\n", a + y, sizeof(a + y));
printf("%f,%d\n", a + y, sizeof(a + y));

float x = 10.85;
printf("%p", &x);

printf("%c,%d\n", a + x, sizeof(a + x));
printf("%d,%d\n", a + x, sizeof(a + x));
printf("%f,%d\n", a + x, sizeof(a + x));

system("pause");
}
输出
0018FCE7a,1
97,1
0.000000,0
0018FCDBa,1
97,1
0.000000,0
0018FCCCf,4
102,4
0.000000,0
0018FCC0
/*
上面的代码说明一个问题，不论以ASCII值赋值还是ASCII编号赋值，
由前面所学我们也知道,字符型数据，整型数据和浮点型数据
在内存中存储的格式是不同的，其中字符型是按照ASCII形式存储的，整数型是按照补码的形式存储的，而浮点型是按照指数与小数部分存储的
*/
```
