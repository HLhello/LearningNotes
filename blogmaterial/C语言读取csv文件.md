## C语言读取csv文件

在做中兴挑战赛时，需要读取csv文件，当时不知道有没有现成的函数调用，所以自己写了一个C语言读取csv文件的函数，没有测试过性能，后来用matlab实现了挑战赛，所以就没有用C语言，贴出来希望如果有大佬的话指教一二

**逗号分隔值**（Comma-Separated Values，**CSV**，有时也称为**字符分隔值**，因为分隔字符也可以不是逗号），其文件以纯文本形式存储表格数据（数字和文本）。纯文本意味着该文件是一个字符序列，不含必须像二进制数字那样被解读的数据。CSV文件由任意数目的记录组成，记录间以某种换行符分隔；每条记录由字段组成，字段间的分隔符是其它字符或字符串，最常见的是逗号或制表符。通常，所有记录都有完全相同的字段序列。通常都是纯文本文件。建议使用WORDPAD或是记事本来开启，再则先另存新档后用EXCEL开启，也是方法之一。

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int get_row(char *filename);
int get_col(char *filename);
void get_relationship(int** data, char* filename, int col);

void main()
{
	char filename[] = "./Example.csv";
   
    int row, col;
    row = get_row(filename);
    col = get_col(filename);
    printf("row = %d, col = %d\n", row, col);
    int **data;
    data = (int **)malloc(row * sizeof(int *));
    for(int i=0; i<row; i=i+1)
    {
        data[i] = (int *)malloc(col * sizeof(int));
    }

    get_relationship(data, filename, col);
    printf("\nhello");
}

int get_row(char *filename)
{
    FILE* stream = fopen(filename, "r");
    int i = 0;

    while(fgetc(stream) != EOF)
    {
        if(fgetc(stream) == '\n')
        {
            i++;
        }
    }
    fclose(stream);
    return i;
}

int get_col(char *filename)
{
    FILE* stream = fopen(filename, "r");
    int i = 0;
    int x;
    while((x = fgetc(stream)) != '\n')
    {
        if(x == ',')
        {
            i++;
        }
    }
    fclose(stream);
    return i+1;
}

void get_relationship(int** data, char* filename, int col)
{
	FILE* stream = fopen(filename, "r");
    char line[2*col+1];
	int i = 0;
	while (fgets(line, 2*col+1, stream))
    {
    	int j = 0;
    	char *tok;
        char* tmp = strdup(line);
        for (tok = strtok(line, ","); tok && *tok; j++, tok = strtok(NULL, ",\n"))
        {
        	data[i][j] = atof(tok);
		}
        i++;
        free(tmp);
    }
    fclose(stream);
}
```







