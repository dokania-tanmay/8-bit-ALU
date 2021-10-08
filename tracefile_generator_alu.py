#Python code for TRACEFILE.txt generation for the ALU
#
#open/create TRACEFILE.txt in write mode
f = open("TRACEFILE.txt","w")
#number of inputs
input_len = 19
#number of outputs
output_len = 16
#number of test vectors
test_len = 2**input_len
#loop from 0 to (test_len-1)
for input_vec in range(test_len):
#convert input to binary(19bit) format
    input_str = "{:019b}".format(int(input_vec))
#extracting the input bits
    sel = (input_vec & 0x70000)>>16
    a = (input_vec & 0xFF00)>>8
    b = (input_vec & 0x00FF)
    output = 0
    # Running different operations based on different select bit values.
    if sel==0:
        output = a + b
    
    elif sel==1:
        output = a * b
    
    elif sel==2:
        if b%2 == 0:
            bprime = b+1
        else:
            bprime = b
        quo = int(a/bprime)
        rem = a%bprime
        output = (rem<<8) + quo
    
    elif sel==3:
        output = a ^ b
    
    elif sel==4:
        output = a << 1
    
    elif sel==5:
        output = a << 2

    elif sel==6:
        output = a << 4

    else:
        output = a << 8


#convert output to binary(16bit) format
    output_str = "{:016b}".format(int(output))
#write input and output test vector with 16bit mask in TRACEFILE.txt
    f.write(input_str + " " + output_str + " 1111111111111111\n")
#close file
f.close() 
