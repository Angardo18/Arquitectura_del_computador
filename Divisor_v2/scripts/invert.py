for i in range(32):
    s = "dFlipFlop fb{}(resta[{}],clkReg,r,remainder[{}]);".format(i,i,i)
    print(s)