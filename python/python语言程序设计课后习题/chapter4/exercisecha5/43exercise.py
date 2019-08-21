cnt = 0

for i in range(1,7+1):
    for j in range(i+1,7+1):
        print(i,j,end="      ")
        cnt+=1
    print("")
print(cnt)