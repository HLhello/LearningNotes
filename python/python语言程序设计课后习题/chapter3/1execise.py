import turtle
import math
r = eval(input("请输入中心到顶点的距离："))
turtle.showturtle()
turtle.circle(r,steps=6)

pi = 3.1415926
s = 2*r*math.sin(pi/5)
area = 5*s*s/(4*math.tan(pi/5))
turtle.penup()
turtle.write(round(area,2))
turtle.goto(0,r)
turtle.pendown()
turtle.goto(0,0)

#print(("%2.2f")%area)
turtle.done()