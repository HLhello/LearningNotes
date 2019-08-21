import turtle as tt
import random
tt.showturtle()
tt.goto(0,100)
tt.goto(100,0)
tt.goto(0,0)
tt.goto(0,-100)
tt.goto(-100,-100)
tt.goto(-100,100)
tt.goto(100,100)
tt.goto(100,0)
tt.goto(100,-100)
tt.goto(0,-100)
cnt = 0
cnt1 = 0
cnt2 = 0
cnt3 = 0
cnt4 = 0
while cnt < 100:
    cnt += 1
    x = random.randint(-100,100)
    y = random.randint(-100,100)
    if x<0:
        cnt1+=1
        tt.penup()
        tt.goto(x,y)
        tt.pendown()
        tt.dot(10, "red")
    elif x>0 and y>0 and x+y>100:
        cnt2+=1
        tt.penup()
        tt.goto(x,y)
        tt.pendown()
        tt.dot(10, "blue")
    elif x>0 and y>0 and x+y<100:
        cnt3+=1
        tt.penup()
        tt.goto(x,y)
        tt.pendown()
        tt.dot(10, "yellow")
    elif x>0 and y<0:
        cnt4+=1
        tt.penup()
        tt.goto(x,y)
        tt.pendown()
        tt.dot(10, "black")
print(cnt1,cnt3)
print(cnt2,cnt4)
tt.done()
