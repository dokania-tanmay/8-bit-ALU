#Python code for TRACEFILE.txt generation for 8 bit multiplier 8 bit * 8 bit = 16 bit
#
#open/create TRACEFILE.txt in write mode
f = open("TRACEFILE.txt","w")
#number of inputs
input_len = 16
#number of outputs
output_len = 16
#number of test vectors
test_len = 2**input_len
#loop from 0 to (test_len-1)
for input_vec in range(test_len):
#convert input to binary(16bit) format
	input_str = "{:016b}".format(int(input_vec))
#extracting the input bits
	a = input_vec & 0x00FF
	b = (input_vec & 0xFF00)>>8


#generating the output
	output = a*b
#convert output to binary(16bit) format
	output_str = "{:016b}".format(int(output))
#write input and output test vector with 16bit mask in TRACEFILE.txt
	f.write(input_str + " " + output_str + " 1111111111111111\n")
#close file
f.close() 
