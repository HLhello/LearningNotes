'''
gcd=1 #Initial gcd is 1
int k=2 #Possible gcd
while k <= nl and k <= n2:
    if nl%k==0 and n2%k==0:
        gcd=k
        k+=1#Next possible gcd
#After the loop,gcd is the greatest common divisor for n1 and n2
'''
'''
#Prompt the user to enter two integers
n1=eval(input("Enter first integer:"))
n2=eval(input("Enter second integer:"))
gcd=1
k=2
while k <= n1 and k <= n2:
    if n1%k==0 and n2%k==0:
        gcd=k
    k+=1
print("The greatest common divisor for", n1,"and",n2,"is",gcd)
'''
n1 = eval(input("Enter first integer: "))
n2 = eval(input("Enter second integer: "))
gcd = 1
k = 2
if n1 < n2:
    for i in range(n1,0,-1):
        if n1%i == 0 and n2%i == 0:
            gcd = i
            break
else:
    for i in range(n2,0,-1):
        if n1%i == 0 and n2%i == 0:
            gcd = i
            break
print(gcd)