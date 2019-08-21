import time

secs = int(input("Enter an number of seconds:"))
for i in range(secs,0,-1):
    if i>1:
        print(i,"seconds remaining")
        time.sleep(1)
    else:
        time.sleep(1)
        print("stoped")
