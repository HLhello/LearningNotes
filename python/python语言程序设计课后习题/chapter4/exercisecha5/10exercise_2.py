file_3 = open('./3.txt', 'a')

file_1 = open('1.txt')
for line in file_1.readlines():
    rd1 = line.split(' ')
    print(rd1)

    file_3.write(rd1[0])
    file_3.write('\n')

file_2 = open('2.txt')
for line in file_2.readlines():
    rd2 = line.split(' ')
    print(rd2)

    file_3.write(rd2[0])
    file_3.write('\n')
