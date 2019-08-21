import turtle as tt
import random

tt.speed(100)
tt.showturtle()
tt.color("grey")

x = -200
for y in range(-200,200+1,25):
    tt.penup()
    tt.goto(x,y)
    tt.pendown()
    tt.forward(400)

y = 200
tt.right(90)
for x in range(-200,200+1,25):
    tt.penup()
    tt.goto(x,y)
    tt.pendown()
    tt.forward(400)

tt.pensize(3)
tt.color("red")

tt.penup()
tt.home()
tt.pendown()

x = y = 0
tt.speed(100)
while abs(x)<200 and abs(y)<200:
    r = random.randint(0,3)
    if r==0:
        x+=25
        tt.setheading(0)
        tt.forward(25)
    elif r==1:
        y -= 25
        tt.setheading(270)
        tt.forward(25)
    elif r==2:
        x-=25
        tt.setheading(180)
        tt.forward(25)
    elif r==3:
        y+=25
        tt.setheading(90)
        tt.forward(25)
tt.done()