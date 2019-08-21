pos_count = 0
neg_count = 0
sum = 0
while True:
    num = int(input("Enter a number:"))
    sum  =  sum+num
    print("this is num",num,"this is sum",sum)
    if num>0:
        pos_count += 1
        print("this is pos ",pos_count)
    elif num<0:
        neg_count += 1
        print("this is neg ", neg_count)
    elif num==0:
        break

    avg = sum / (pos_count + neg_count)
print(avg)