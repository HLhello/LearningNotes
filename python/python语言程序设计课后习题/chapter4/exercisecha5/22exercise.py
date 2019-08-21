NUMBER_OF_PRIMES=1000
NUMBER_OF_PRIMES_PER_LINE=8
count=0
number=2
print("The first 50 prime numbers are")
while number <= NUMBER_OF_PRIMES:
    isPrime=True
    divisor=2
    while divisor<=number/2:
        if number % divisor==0:
            isPrime=False
            break
        divisor+=1
    if isPrime:
        count+=1
        print(format(number,"5d"),end=" ")
        if count % NUMBER_OF_PRIMES_PER_LINE ==0:
            print()
    number+=1