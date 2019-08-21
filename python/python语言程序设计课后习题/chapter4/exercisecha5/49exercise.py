import turtle as tt
cnt = 0
tt.showturtle()
print("  ",end="  \t")
tt.write(" \t")
for k in range(1,10,1):
    print(format(k,"2d"),end="  \t")
    tt.write("s\t")
print("")
tt.write("\n")
print("-"*75)
for i in range(1,10,1):
    print("%2d"%i,"|",end="  \t")
    tt.write("d\t")
    for j in range(1,10,1):
        print(format(i*j,"2d"),end="  \t")
        tt.write("d\t")
        cnt += 1
        if cnt%9==0:
            print("\t")
            tt.write("\n")



tt.done()