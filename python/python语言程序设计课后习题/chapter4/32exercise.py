money = eval(input("Enter every month money:"))
month = int(input("Enter total months:"))
rate = eval(input("Enter interest rate:"))
#32
'''
balance = 0
for i in range(month):
    balance = (balance+money)*(1+rate/12)
    print(balance)
'''
#33
for i in range(month):
    money = money*(1+rate/1200)
    print(money)