import turtle as tt
tt.showturtle()
for i in range(0,100,10):
    tt.penup()
    tt.goto(0,-i)
    tt.pendown()
    tt.circle(i+10)
tt.done()
