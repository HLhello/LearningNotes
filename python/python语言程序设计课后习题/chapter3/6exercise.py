num = int(input("Enter a number:"))
thud = num//1000
hund = num%1000//100
tens = num%100//10
ones = num%10

covnum = ones*1000 + tens*100 + hund*10 + thud
print(covnum)