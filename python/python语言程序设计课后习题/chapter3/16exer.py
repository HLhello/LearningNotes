status =eval(input("(O-single filer,1-married jointly,\n"+
                   "2-married separately,3-head of household)\n"+
                   "Enter the filing status:"))
income=eval(input("Enter the taxable income:"))

tax=0

if status==0:# Compute tax for single filers
    if income<=8350:
        tax=income*0.10
    elif income<=33950:
        tax=8350*0.10+(income-8350)*0.15
    elif income<=82250:
        tax=8350*0.10+(33950-8350)*0.15+(income-33950)*0.25
    elif income<=171550:
        tax=8350*0.10+(33950-8350)*0.15+(82250-33950)*0.25+(income-82250)*0.28
    elif income<=372950:
        tax=8350*0.10+(33950-8350)*0.15+(82250-33950)*0.25+(171550-82250)*0.28+(income-171550)*0.33
    else:
        tax=8350*0.10+(33950-8350)*0.15+(82250-33950)*0.25+(171550-82250)*0.28+(372950-171550)*0.33+(income-372950)*0.35
elif status==1:
    pass
elif status==2:
    pass
elif status==3:
    pass

print(tax)