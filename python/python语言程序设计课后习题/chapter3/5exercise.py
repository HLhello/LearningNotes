amount = eval(input("Enter an amount:"))
cent = round(amount*100)# 讲输入的小数点后两位用四舍五入精确
yuan = cent//100
jiao = cent%100//10
fen = cent%10
print (yuan , "元" , jiao , "角" , fen , "分" )
