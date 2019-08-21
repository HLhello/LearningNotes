year = eval(input("years:"))
time = year*365*24*3600
increased = time//7 - time//13 + time //45
print(increased)
