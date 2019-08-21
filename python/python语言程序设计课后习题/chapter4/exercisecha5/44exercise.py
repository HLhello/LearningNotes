num = int(input("Enter a number to binary/HEX:"))
'''
cntb=0
while num>=1:
    bin = num % 2
    num = num//2
    print(bin,end="")
    cntb+=1
print(cntb)

'''
cnth = 0
while num>=1:
    hex =  num%16
    num = num//16
    cnth +=1
    if hex>=10:
        hex = chr(65+(hex%10))
    print(hex,end="")
#print(cnth)