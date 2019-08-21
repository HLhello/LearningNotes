loan = eval(input("Enter loan amount:"))
year = eval(input("Ente number of years:"))
rate = 0.05

print("Interest Rate"," "*5,"Monthly Payment"," "*5,"Total Payment")
while rate<=0.08:
    rate = rate + 1/800
    monthly = loan*rate/12 / (1 - (1 / ((1+rate) ** year) ))
    total = monthly * year * 12
    #print(rate,"\t\t", monthly,"\t\t",total,"\t\t")
    print(format(rate,"1.3%"),end=" "*15)
    print(format(monthly, "3.2f"), end=" " * 15)
    print(format(total, "5.2f"), end=" " * 5)
    print("")