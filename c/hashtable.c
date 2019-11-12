#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<time.h>
#include<io.h>
#include<string.h>

#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0

#define MAXSIZE 100

#define SUCCESS 1
#define FAILED 0
#define HASHSIZE 12
#define NULLKEY -32768

typedef int Status;

typedef struct
{
    int *elem; //鏁版嵁鍏冪礌瀛樺偍鍩哄潃锛屽姩鎬佸垎閰嶆暟缁�
    int count; //褰撳墠鏁版嵁鍏冪礌涓暟
}HashTable;

int m=0;

Status InitHashTable(HashTable *H)
{
    int i;
    m = HASHSIZE;
    H->elem = (int *)malloc(m*sizeof(int));
    for(i=0; i<m; i++)
    {
        H->elem[i] = NULLKEY;
    }
    return OK;
}

int Hash(int key)
{
    return key % m;
}

void InsertHash(HashTable *H,int key)
{
    int addr = Hash(key);
    while (H->elem[addr] != NULLKEY)
    {
        addr = (addr+1) % m;
    }
    H->elem[addr] = key;
}

Status SearchHash(HashTable H, int key, int *addr)
{
    *addr = Hash(key);
    while(H.elem[*addr]!=key)
    {
        *addr = (*addr+1)%m;
        if(H.elem[*addr]==NULLKEY || *addr==Hash(key))
            return FAILED;
    }
    return SUCCESS;
}

void main()
{
    int arr[HASHSIZE] = {12,67,56,16,25,37,22,29,15,47,48,34};
    int i,p,key,result;
    HashTable H;

    key = 39;
    InitHashTable(&H);
    for(i=0;i<m;i++)
    {
        InsertHash(&H,arr[i]);
    }

    result = SearchHash(H,key,&p);
    if(result) printf("鏌ユ壘 %d 鐨勫湴鍧€涓猴細\n",key,p);
    else printf("鏌ユ壘 %d 澶辫触\n",key);

    for(i=0;i<m;i++)
    {
        key = arr[i];
        SearchHash(H,key,&p);
        printf("鏌ユ壘 %d 鐨勫湴鍧€涓猴細\n",key,p);
    }
}