import random
a = random.randint(0,9)
b = random.randint(0,9)
c = random.randint(0,9)
answer = a + b + c

x = eval(input("calc the equation %d+%d+%d:"%(a,b,c)))
if x == answer:
    print("you are right!")
else:
    print("lol")