'''
#1.
celsius = eval(input("celsius:"))
fahrenheit = (9/5)*celsius + 32
print("fahrenheit:", fahrenheit)
#2.
radius, length = eval(input("Enter radius and length:"))
area = radius * radius * 3.14
volume = area *length
print("this is area:", area)
print("this is volume:",volume)
#3.
feet = eval(input("Enter a value for feet:"))
meter = feet *0.305
print(feet," feet is ",meter," meters")
#4.
subtotal, gratuity = eval(input("Enter subtotal and gratuity rate:"))
gratuity = gratuity*subtotal/100
total = subtotal + gratuity
print("the total is ",round(total,2),"the guatutiy is ",round(gratuity,2))
#6.
num = int(input("Enter a number between 0 and 1000:"))
thud = num//1000
hund = num%1000//100
tens = num%100//10
ones = num%10
sum =  thud + hund + tens + ones
print("the sum of digits is:",sum)
#7.
final_acount = eval(input("Enter final account value:"))
interest_rate = eval(input("Enter interest rate percent:"))
years = eval(input("Enter years value:"))
initial_deposit = final_acount/((1+interest_rate/100)**years)
print("initial deposit value is:",initial_deposit)
#21.暂时不会！
months, interest_rate, every_mon_deeposit = \
    eval(input("Enter months, interest rste and every month deposit:"))
for i in  range(months):
    sub = 100*(1+interest_rate)
#22.
year = eval(input("years:"))
time = year*365*24*3600
increased = 312032486 + time//7 - time//13 + time //45
print(increased)
'''


