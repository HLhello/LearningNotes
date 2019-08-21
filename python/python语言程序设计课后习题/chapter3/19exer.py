import turtle as tt
x,y = eval(input("Enter x and y:"))

tt.showturtle()
tt.hideturtle
tt.goto(200,0)
tt.goto(0,100)
tt.goto(0,0)

tt.penup()
tt.goto(x,y)
tt.pendown()
tt.dot(5)

if y<(-1/2)*x + 100:
    print("the point is in the triangle")
else:
    print("the point is not in the triangle")

tt.done()