import turtle as tt
tt.showturtle()
for i in range(1,11,1):
    for i in range(1,i+1):
        print(format(i,"2d"),end=" ")
        num = str(i) + str(" ")
        tt.write(num,"\t\t")
    print("")
    tt.write(" \r\r\n")
tt.done()
'''
在turtle中写文本的方法到底都没搞明白-_-!

'''