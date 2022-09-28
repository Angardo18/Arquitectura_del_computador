
#parametros
count = 2
ffBaseName = "fra"

print("module register_32b{}(input [31:0] value, input clk,r,output [31:0] Q);".format(count))
for i in range(32):
    s = "\tdFlipFlop {}{}(value[{}],clk,r,Q[{}]);".format(ffBaseName,i,i,i)
    print(s)
print("endmodule")