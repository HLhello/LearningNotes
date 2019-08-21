import math
print(" angle |     sin    |     cos    ")
for angle in range(0,360,10):
    mysin = math.sin(angle)
    mycos = math.cos(angle)
    print(format(angle,"3d"),"     ",format(mysin,"<1.4f"),"     ",format(mycos,"<1.4f"))
# 8 is similar to 7
