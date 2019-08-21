print("    kg    |   pond   ")
print("---------------------")

for i in range(100):
    kg = 2 * i + 1
    pond = kg*2.2

    print("   %4d   |   %3.1f   "%(kg,pond))
    print("---------------------")