#1.
print("welcome to python")
print("welcome to computer science")
print("programmong is fun")
#2.
for i in range(5):
    print("welcome to python")
#3.
print("FFFFFFF   U     U   NN    NN\n"
      "FF        U     U   NNN   NN\n"
      "FFFFFFF   U     U   NN N  NN\n"
      "FF         U   U    NN  N NN\n"
      "FF          UUU     NN   NNN")
#4.
a = [1,2,3,4]
a2 = []
a3 = []
print("a    a^2  a^3")
for i in a:
    a_2 = i**2
    a2.append(a_2)
    a_3 = i**3
    a3.append(a_3)
for i in range(4):
    print(a[i],"  ",a2[i],"  ",a3[i])

#5
x = (9.5*4.5-2.5*3)/(45.5-3.5)
print(x)

#6
x = 0
for i in range(10):
    x = x+i
    print(i)
print(x)

#7
x = 0
y = 0
z = 0
for i in range(5):    #改为while循环即可
    x = (-1)**i
    y = x/(2*i+1)
    print(y)
    z = z + y
pi = 4*z
print(pi)



