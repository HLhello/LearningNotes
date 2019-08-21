for i in range(1,100001,1):
    num = 0
    for j in range(1,i+1,1):
        if i%j==0:
            k = i/j
            num = num +k
    if num==2*i:
        print(i)