import random

num1 = random.randint(0,1)
num2 = random.randint(0,1)
while num1==num2:
    num2 = random.randint(0,1)
print(num1,num2)
