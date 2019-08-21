year = input("Enter which year:")
week = input("Enter whick day:")
year = int(year)
week = int(week)
#判断年份是不是瑞年
if (year%4==0 and year%100!=0) or year%400==0:
    leapyear = True
else:
    leapyear = False

for i in range(1,13):
    #输出十二个月的抬头
    print(" "*20,i," ",year,)
    print("-"*51)
    print("Sun \tMon \tTue \tWed \tThu \tFri \tSat \t\t")
    #判断每月有几天
    if i==1 or i==3 or i==5 or i==7 or i==8 or i==10 or i==12:
        days = 31
    elif i==2:
        if leapyear:
            days = 29
        else:
            days = 28
    else:
        days = 30

    monthDay = days # 为每月天数设置的变量
    count = 0 # 为每周七天设置的变量
    weekD = week
    week = (days+weekD)%7
    for k in range(weekD):
        print("    ", end="   \t")
        count += 1
    for j in range(1,days+1):
        count += 1
        monthDay -= 1

        print(j," ",end=" \t")
        #判断天数是否是七天的倍数或者月份的倍数
        if count%7==0:
            print("")
        elif monthDay==0:
            print("")





