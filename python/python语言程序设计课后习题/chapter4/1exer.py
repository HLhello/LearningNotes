import time
import random

correct = 0
count = 0
questions = 5
computer = 0
StartTime = time.time()
while count < questions:
    num1 = random.randint(0,9)
    num2 = random.randint(0,9)
    computer  = num1 + num2
    user = eval(input("%d + %d = "%(num1,num2)))
    if user == computer:
        correct +=1
    else:
        correct = correct

    count += 1
EndTime = time.time()
testTime = int(EndTime - StartTime)

print("Correct count is ",correct)
print("Test time is ",testTime)
