from random import randint
import time

corrrct = 0

beginTime = time.time()
for i in range(5):
    num1 = randint(1,15)
    num2 = randint(1,15)
    computer = num1 + num2
    user = int(input("%d + %d = "%(num1,num2)))
    if user == computer:
        corrrct += 1
    else:
        corrrct = corrrct
endTime = time.time()
testTime = int(endTime - beginTime)

print("this is calc right numbers ",corrrct)
print("use %d secs"%testTime)