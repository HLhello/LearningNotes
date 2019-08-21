time = eval(input("请输入总用时："))
distance = eval(input("请输入距离："))
min = time / 1
print(min)
sec = time - min
hrs = (min*60 + sec)/3600
print(hrs)
mile = distance/1.6

v = mile / hrs
print(v)