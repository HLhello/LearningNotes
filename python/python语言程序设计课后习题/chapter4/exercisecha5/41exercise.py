largest = 0
while True:
    num = int(input("Enter a number:"))
    if num == 0:
        break
    if num>= largest:
        largest = num
    print(largest)