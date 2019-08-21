a,b,c = eval(input("Enter ax^2 + bx + c = 0:"))
delt = b**2 -4*a*c

if delt < 0:
    print("the equation has no real roots")
elif delt == 0:
    root = -b/2*a
    print("the root is %.5f"%root)
else:
    root1 = (-b + delt**0.5)/2*a
    root2 = (-b - delt**0.5)/2*a
    print("the roots are %.5f and %.5f"%(root1,root2))