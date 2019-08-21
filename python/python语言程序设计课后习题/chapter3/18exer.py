year,mon,day = eval(input("Enter year,mon and days:"))

if mon <= 2:
    mon = mon + 12
else:
    mon =  mon

century = year//100
decades = year%100

today = (day + (26*(mon+1)//10) + decades + (decades//4) + (century//4) + 5*century)%7

if today == 2 :
    today = "Monday"
elif today == 3:
    today = "Tuesday"
elif today == 4:
    today = "Wednesday"
elif today == 5:
    today = "Thursday"
elif today == 6:
    today = "Friday"
elif today == 0:
    today = "Saturday"
elif today ==1 :
    today = "Sunday"
elif today<0 and today>6:
    print("input is illegal")

print("today is %s"%today)
