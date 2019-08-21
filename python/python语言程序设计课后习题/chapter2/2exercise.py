import turtle
radius = eval(input("Enter an radius:"))
area = radius * radius * 3.14
turtle.showturtle()
turtle.circle(radius)
turtle.penup()
turtle.goto(0,radius)
turtle.write(area)

turtle.done()