
fee = 10000
tuition = 10000
rate = 0.05
total = 0
for i in range(10):
    print(i)
    fee = (1+rate)*fee
    print(fee)
    for j in range(4):
        tuition = (1 + rate) * tuition
        total = total + tuition
    print(total)

