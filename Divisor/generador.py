
baseName = "n"
baseName2 = "ffd"
#mux m1(value[31],in,load,d[31]);

for i in range(32):
    s = "mux {}{} (value[{}],Q[{}],load,d[{}]);".format(baseName,31-i,i,i+1,i)
    print(s)
#dFlipFlop ff1(d[15],clk,r,Q[15]);
print("//--------- FLIP FLOPS D -----------------------------")
#baseName2 = "ffd"
for i in range(32):
    s = "dFlipFlop {}{}(d[{}],clk,r,Q[{}]);".format(baseName2,31-i,i,i)
    print(s)