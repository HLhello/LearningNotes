```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int get_row(char *filename);
int get_col(char *filename);
void get_relationship(int** data, char* filename);

void main()
{
	char filename[] = "E:\\ZTEchallenge\\c_src\\Example.csv";
   
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

    get_relationship(data, filename);
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

void get_relationship(int** data, char* filename)
{
	FILE* stream = fopen(filename, "r");
    char line[2048];
	int i = 0;
	while (fgets(line, 2048, stream))
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

