import turtle as tt

tt.showturtle()



x1,y1 = eval(input("Enter an point:"))
x2,y2 = eval(input("Enter an point:"))
x3,y3 = eval(input("Enter an point:"))

s1 =( (x1-x2)**2 + (y1-y2)**2 )**0.5
s2 =( (x3-x2)**2 + (y3-y2)**2 )**0.5
s3 =( (x3-x2)**2 + (y3-y2)**2 )**0.5


tt.penup
tt.goto(x1,y1)
tt.pendown()
tt.goto(x2,y2)
tt.write(s1)
tt.goto(x3,y3)
tt.write(s2)
tt.goto(x1,y1)
tt.write(s3)


tt.done()