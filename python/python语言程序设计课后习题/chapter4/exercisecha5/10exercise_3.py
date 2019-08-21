#找到第二大的数的算法
file = open('3.txt')
maxscore = 0
for line in file.readlines():
    score = line.split('\n')
    score = score[0]
    score =  eval(score)

    if maxscore<score:
        maxscore = score
    else:
        maxscore = maxscore
print(maxscore)
one = 0
two = 0
file = open('3.txt')
for line in file.readlines():
    score = line.split('\n')
    score = score[0]
    score = eval(score)
    if score > one:
        two =  one
        one = score
    elif score > two:
        two = score
print(two)