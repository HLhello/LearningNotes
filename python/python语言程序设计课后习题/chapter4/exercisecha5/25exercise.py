#25
'''

num1 = 0
num2 = 0
for i in range(1,50001):
    num1 += 1/i
print(num1)
for i in range(50000,0,-1):
    num2 += 1/i
print(num2)

'''

'''
会产生误差，具体哪个精确不知道
'''
#26
'''
num3 = 0
for i in range(50):
    num3 = (2*i-1)/(2*i+1)
print(num3)
'''

#27
'''
num4_1 = 0
numa = 0
for i in range(1,10000):
    numa +=  ( (-1)**(i+1) ) / (2*i-1)
    num4_1 =  4*numa
print(num4_1)

num4_2 = 0
numb = 0
for i in range(1,100000,1):
    numb +=  ( (-1)**(i+1) ) / (2*i-1)
    num4_2 =  4*numb
print(num4_2)

num4_3 = 0
numc = 0
for i in range(1,1000000,1):
    numc +=  ( (-1)**(i+1) ) / (2*i-1)
    num4_3 =  4*numc
print(num4_3)
'''
#28
fac = 1
x = 0
for i in range(1,100):
    fac = fac*i
    x += 1/fac
e = x +1
print(e)

