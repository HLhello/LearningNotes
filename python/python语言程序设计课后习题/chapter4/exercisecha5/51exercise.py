import turtle as tt

tt.showturtle()
tt.speed(1000)
for i in range(-90,91,10):
    tt.penup()
    tt.goto(-90,i)
    tt.pendown()
    tt.forward(180)
tt.right(90)
for i in range(-90,91,10):
    tt.penup()
    tt.goto(i,90)
    tt.pendown()
    tt.forward(180)

tt.right(45)
for i in range(-90,90,20):
    for j in range(90,-90,-20):
        tt.penup()
        tt.goto(i,j)
        tt.pendown()
        tt.begin_fill()
        tt.circle(7,steps=4)
        tt.color("black")
        tt.end_fill()
for i in range(-80,90,20):
    for j in range(80,-90,-20):
        tt.penup()
        tt.goto(i,j)
        tt.pendown()
        tt.begin_fill()
        tt.circle(7,steps=4)
        tt.color("black")
        tt.end_fill()
tt.penup()
tt.goto(100,100)
tt.pendown()
tt.write("Vans",font=('Times',18,"bold"))

tt.done()