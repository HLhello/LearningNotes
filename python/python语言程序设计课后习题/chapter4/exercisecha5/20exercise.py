line = int(input("Enter an number lager than 0 and smaller than 16: "))
#A
'''
1
12
123
1234
for i in range(1,line+1):
    j = 1
    while j<=i:
        print(j,end="")
        j += 1
    print("")
'''
#B
'''
4321
321
21
1
for i in range(line,0,-1):
    for j in range(i,0,-1):
        print(j,end="")
    print("")
'''
#C
'''
   1
  12
 123
1234
for i in range(1,line+1):
    j = 1
    print(" " * (line-i), end="")
    while j<=i:
        print(j,end="")
        j += 1
    print("")
'''
#D
'''
1234
 123
  12
   1
for i in range(1,line+1):
    print(" "*(i-1),end="")
    for j in range(1,line-i+2):
        print(j,end="")
    print("")

'''
#19
'''
for i in range(1,line+1):
    print(" "*(line-i),end="")
    for j in range(i,0,-1):
        print(j,end="")
    print("")

'''

for i in range(line):
    for j in range(0,line-i):
        print(end=' ')
    for k in range(line-i,line):
        print('*',end=' ')
    print('')
