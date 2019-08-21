import random
count = 0
while  count<2:
    user = int(input("scissor(0),rock(1),paper(2):"))
    computer = random.randint(0, 2)
    if user == 0:
        if computer == 0:
            print("The computer is scissor and you are scissor. It is a draw.")
        elif computer == 1:
            print("The computer is rock and you are scissor. You lose.")
        elif computer == 2:
            print("The computer is paper and you are scissor. You won.")
            count = count+1
    elif user == 1:
        if computer == 0:
            print("The computer is scissor and you are rock. You won.")
            count = count + 1
        elif computer == 1:
            print("The computer is rock and you are rock too. It is a draw.")
        elif computer == 2:
            print("The computer is paper and you are rock. You lose.")
    elif user == 2:
        if computer == 0:
            print("The computer is scissor and you are paper. You lose.")
        elif computer == 1:
            print("The computer is rocck and you are paper. You won.")
            count = count + 1
        elif computer == 2:
            print("The computer is paper and you are paper too. It is a draw.")
    else:
        print("input is illegal")