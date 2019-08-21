file_object = open("fourclass.txt")
for line in file_object.readlines():
    rd = line.split(':')
    print(rd)

    file_1 = open('./1.txt','a')
    file_1.write(rd[1])
    file_1.write('\n')

    file_1 = open('./2.txt','a')
    file_1.write(rd[2])
