count = 0
for i in range(ord("!"),ord("~")):
    count += 1
    print(chr(i),end=" ")
    if count%10==0:
        print(" ")