#判断是不是瑞年
#根据月份显示有多少天
year,mon = eval(input("Enter year and month:"))

if (year%4==0 and year%100!=0) or year%400==0:
    year = True
else:
    year =  False

if mon==2:
    if year is False:
        print("this month has 28 days")
    else:
        print("this month has 29 days")
elif mon==1 and mon==3 and mon==5 and mon==7 and mon==8 and mon==10 and mon==12:
    print("this month has 31 days")
elif mon==2 and mon==4 and mon==6 and mon==9 and mon==12:
    print("this month has 30 days")
else:
    print("input is illegal")
