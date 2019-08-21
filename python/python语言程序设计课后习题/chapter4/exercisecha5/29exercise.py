count = 0
for i in range(2001,2101):
    if i%4==0 and i%100!=0:
        print(i,end=" ")
        count += 1
        if count%10 == 0:
            print("")

