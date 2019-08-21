import turtle as tt
import math
tt.speed(1000)
tt.showturtle()
tt.penup()
tt.goto(-300,0)
tt.pendown()
tt.forward(600)

tt.penup()
tt.goto(0,-100)
tt.pendown()
tt.goto(0,100)
tt.right(45)
tt.forward(10)

tt.penup()
tt.goto(0,100)
tt.pendown()
tt.right(90)
tt.forward(10)

tt.penup()
tt.goto(300,0)
tt.pendown()
tt.forward(10)

tt.penup()
tt.goto(300,0)
tt.pendown()
tt.right(90)
tt.forward(10)
tt.penup()
tt.goto(-275, 50 * math.sin((-275 / 100) * 2 * math.pi))
tt.pendown()
for x in range(-275,276):

    tt.goto(x,50*math.sin((x/100) * 2 * math.pi + math.pi/2))

tt.penup()
tt.goto(-10,100)
tt.pendown()
for x in range(-10,11):
    tt.goto(x,x**2)
tt.done()

#如何把参数进一步划分？就是描述更细致一点