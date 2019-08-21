num =  int(input("Enter an number: "))
'''
1.判断num是不是素数
2.若num是素数
    输出num
3.若num不是素数
    将所有小于num的素数找出来
        判断num是否能够整除小于num的素数
            若能
                一直整除，直到模该素数的余数不等于0，递归调用，
                换下一个
                将其全部输出
'''
isprime = True
divisor = 2
while divisor <= num/2:
    if num%divisor == 0:
        isprime = False
        break
    divisor += 1
primeGcd = 2
if isprime:
    print("The input num is prime")
else:
    print("The input num is not prime")
    while True:
        if num%primeGcd != 0:
            primeGcd += 1
        else:
            num = num//primeGcd
            print(primeGcd,end=" ")
            if num == 1:
                break



