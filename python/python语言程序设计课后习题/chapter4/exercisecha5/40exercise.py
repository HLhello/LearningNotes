import random
count = 0
count0 = 0
count1 = 0
while count<1000000:
    count +=1
    coin = random.randint(0,1)
    if coin == 0:
        count0+=1
    else:
        count1+=1
print("front numbers",count0,"reverse",count1)
