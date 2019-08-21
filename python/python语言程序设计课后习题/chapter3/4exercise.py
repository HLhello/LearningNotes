import time

mytime = int(time.time())
code = 65 + mytime%26
print(chr(code))
