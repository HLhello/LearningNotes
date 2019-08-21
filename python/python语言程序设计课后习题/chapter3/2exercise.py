import math

x1,y1,x2,y2 = eval(input("Enter two points latitude and longtitude:"))
x1 = math.radians(x1)
x2 = math.radians(x2)
y1 = math.radians(y1)
y2 = math.radians(y2)

radius = 6371.01
d = radius * math.acos(    math.sin(x1)*math.sin(x2) + math.cos(x1)*math.cos(x2)*math.cos(y1-y2)    )
print(d)