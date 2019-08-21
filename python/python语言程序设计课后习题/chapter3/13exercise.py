today = eval(input("Enter today's day:"))
nextday = eval(input("Enter the number of days elapsed since today:"))

future_day = today + nextday%7
if today == 1 :
    today = "Monday"
elif today == 2:
    today = "Tuesday"
elif today == 3:
    today = "Wednesday"
elif today == 4:
    today = "Thursday"
elif today == 5:
    today = "Friday"
elif today == 6:
    today = "Saturday"
elif today == 0 :
    today = "Sunday"
elif today<0 and today>6:
    print("input is illegal")

if future_day == 1 :
    future_day = "Monday"
elif future_day == 2:
    future_day = "Tuesday"
elif future_day == 3:
    future_day = "Wednesday"
elif future_day == 4:
    future_day = "Thursday"
elif future_day == 5:
    future_day = "Friday"
elif future_day == 6:
    future_day = "Saturday"
elif future_day == 0 :
    future_day = "Sunday"
elif future_day<0 and future_day>6:
    print("calc is illegal")

print("today is %s and future day is %s"%(today,future_day))

