// #include<stdio.h>
// #include<stdlib.h>
// void main()
// {
	// printf("hello world");
// }

#include<stdio.h>
#include<time.h>
#define pi 3.14
#define Area(R) pi*R*R
void main()
{
	int r1 = 5,r2 = 2;
	double s = 0;
	s = Area(r1-r2);
	printf("%f",s);
}

// #include<iostream>
// using namespace std;
// class B
// {
// public:
	// B(){f();}
	// virtual void f(){ cout << "B::f"; }
// };
// class D :public B
// {
// public:
	// void f(){ cout << "D::f"; }
// };
// int main(void)
// {
	// B b;
	// D d;
	// B *pb = &b;
	// pb=&d;
	// pb->f();
	// return 0;

// }



// void main()
// {
	// int a,b,c,d;
	// a= 10;
	// b = a++;
	// c = ++a;
	// d = 10*a++;
	// printf("%d,%d,%d,%d",a,b,c,d);
// }
// void main()
// {
    // time_t start, end;
    // time(&start);
    // sleep(3000);
    // time(&end);
    // printf("%d",(unsigned int)(end-start));
// }

// #define _CRT_SECURE_NO_WARNINGS
// #include<stdio.h>
// #include<stdlib.h>
// int main()
// {
	// int n;
	// scanf("%d", &n);
	// int *p1 = (int *)malloc(sizeof(int)*n);//p1
	// for (int i = 0; i < n; i++)
	// {
		// scanf("%d", p1+i);
	// }
	// for (int i = 0; i < n; i++)
	// {
		// printf("%d\t",p1[i]);
	// }
	// printf("\n");
	// int *p2 = (int *)malloc(sizeof(int)*n);//p2
	// for (int i = 0; i < n; i++)
	// {
		// scanf("%d", p2 + i);
	// }
	// for (int i = 0; i < n; i++)
	// {
		// printf("%d\t", p2[i]);
	// }
	// printf("\n");
	// int *index = (int *)malloc(sizeof(int)*n);//index
	// for (int i = 0; i < n; i++)
	// {
		// for (int j = 0;j<n; j++)
		// {
			// if (p1[i] == p2[j])
			// {
				// index[i] = j;
			// }
		// }
	// }
	// for (int i = 0; i < n; i++)
	// {
		// printf("%d\t", index[i]);
	// }
	// printf("\n");
	// int counter = 0;
	// int nummax = 0;
	// int x, y,m;
	// for (int i = 0; i < n-1; i++)
	// {
		// x = index[i];
		// m = i + 1;
		// y = index[m];
		// if (m < n)
		// {
			// while (x<y)
			// {
				// x = y;
				// y = index[m++];
				// counter++;
			// }
 
			// if (counter>nummax)
			// {
				// nummax = counter;
			// }

		// }

	// }

	// printf("%d", n - nummax-1);
	// system("pause");
// }
// #define _CRT_SECURE_NO_WARNINGS
// #include<stdio.h>
// #include<stdlib.h>
// #include <time.h>
// #include<math.h>

// #define limit            2.777578167429134e-11
// #define pi               3.1415926

// float gauss(float n0)
// {
	// float u1, u0;
	// float gaussnoise;
	// u0 = (float)rand() / (float)RAND_MAX;
	// u1 = (float)rand() / (float)RAND_MAX;
	// if (u0<limit) u0 = (float)limit;
	// gaussnoise = (float)(sqrt(n0*log(1/u0))*cos(2 * pi*u1));
	// return gaussnoise;
// }


// void main()
// {
	// time_t theTime;
	//time(&theTime);
	// srand((unsigned int)time(&theTime));
	// float snr[15] = { -3.0, -2.5, -2.0, -1.5, -1.0, -0.5, 0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0 };
	// float n0;
	// for (int i = 6; i < 100; i++)
	// {	
		// n0 = (float) pow(10, -snr[i] / 10);
		// for (int j = 0; j < 20; j++)
		// {
			// printf("%f\n", gauss(n0));
		// }
	// }
	// system("pause");
// }

//这个高斯噪声和MATLAB有啥区别


// void awgn(short *transmit, float *receive, float n0, unsigned short len)
// {
	// int i;
	// float tpf;
	// short tps;
	// n0 = pow(10, -snr / 10);

	// for (i = 0; i<len; i++)
	// {	

		// tps = transmit[i];
		// tps >>= 15;
		// tps &= 0x0001;
		// tps = 1 - 2 * tps;
		// tpf = (float)tps;
		// tpf += gauss(n0);
		// receive[i] = tpf;
	// }

	// return;
// }

// #define _CRT_SECURE_NO_WARNINGS
// #include<stdio.h>
// #include<stdlib.h>
// #include <time.h>
// #include<math.h>

// #define limit            2.777578167429134e-11
// #define pi               3.1415926

// float gauss(float n0)
// {
	// float u1, u0;
	// float gaussnoise;
	// u0 = (float)rand() / (float)RAND_MAX;
	// u1 = (float)rand() / (float)RAND_MAX;
	// if (u0<limit) u0 = (float)limit;
	// gaussnoise = (float)(sqrt(n0*log(1 / u0))*cos(2 * pi*u1));
	// return gaussnoise;
// }

// void input(unsigned char *message, unsigned short len)
// {
	// int i;
	// unsigned short len_d8;
	// unsigned char len_rem;
	// unsigned char pos;

	// len_d8 = len >> 3;
	// len_rem = (unsigned char)(len & 0x07);

	// for (i = 0; i < len_d8; i++)
		// *message++ = rand();
	// pos = 0;
	// for (i = 0; i < len_rem; i++)
	// {
		// pos ^= (0x01 << i);
		// printf("pos = %d\n", pos);
	// }
	

	// *message = rand() & pos;
// }
// #define MSG_LEN_SET    90
// #define MSG_LEN_SET_IB     ((MSG_LEN_SET >> 3) + 1)
// void main()
// {	

	// printf("%x\n", MSG_LEN_SET_IB);
	// unsigned char message[MSG_LEN_SET_IB];
	// int len = MSG_LEN_SET;
	// input(message, len);
	// for (int i = 0;i<MSG_LEN_SET; i++)
	// {
		// printf("%d\n", message[i]);
	// }

	// system("pause");
// }





















// void maingauss()
// {
	// time_t theTime;
	//time(&theTime);
	// srand((unsigned int)time(&theTime));
	// float snr[6] = { 1.0,1.2,1.4,1.6,1.8,2.0};
	// float n0,sigma;
	// for (int i = 0; i < 6; i++)
	// {
		// n0 = (float)pow(10, snr[i] / 10);
		// sigma = (float)(1 / sqrt(n0));
		// printf("sigma = %f\n", sigma);
		// for (int j = 0; j < 2; j++)
		// {
			// printf("%f\n", sigma * gauss(n0));
		// }
	// }
	// system("pause");
// }

//这个高斯噪声和MATLAB有啥区别


//void awgn(short *transmit, float *receive, float n0, unsigned short len)
//{
//	int i;
//	float tpf;
//	short tps;
//	n0 = pow(10, -snr / 10);
//
//	for (i = 0; i<len; i++)
//	{	
//
//		tps = transmit[i];
//		tps >>= 15;
//		tps &= 0x0001;
//		tps = 1 - 2 * tps;
//		tpf = (float)tps;
//		tpf += gauss(n0);
//		receive[i] = tpf;
//	}
//
//	return;
//}