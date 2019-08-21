import time
myclk = time.time()
print(myclk)
myclk_int = int(myclk)
print(myclk_int)
year = myclk_int//(365*24*3600)
print(year)
month = myclk_int%(365*24*3600)//(30*24*3600)
print(month)
day = myclk_int%(30*24*3600)//(24*3600)
print(day)
hour = myclk_int%(24*3600)//3600
print(hour)
min = myclk_int%(3600)//60
print(min)
sec = myclk_int%60
print(sec)

print(1970+year,":",month,":",day,":",hour,":",min,":",sec)