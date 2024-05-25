#!/usr/bin/env python3
import sys

def format_assembly_file(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    for i in range(len(lines)):
        funcHead = ":" in lines[i]
        sep = 3
        temp = lines[i].replace('\n',' ').replace('\t',' ').split(" ")
        print("before:",temp)

        filt = list(filter(lambda x: x!="",temp))
        print("FILTbefore:",filt)
        
        for j in range(len(filt)):
            filt[j] = filt[j].replace(" ","")
            
        b = "|".join(filt)
        print("Bbefore: ",b)
        c = ""
        flag = 0
        for j in range(len(b)):
            if(b[j] == "|"):
                if(flag or b[j+1] == "," ):
                    c+= ""
                    flag = 0
                else:
                    c+= " "
            elif(b[j] == ","):
                c += ", "
                flag = 1
            else:
                c+=b[j]
        print("Bafter: ",c)
        filt = c.split(" ")  
        sep = len(filt) 
        
        print("FILTafter:",filt)
        if(funcHead):
            temp = ("{:12s}"*(sep)).format(*filt)
        elif(len(filt) <= 1 and filt[0] == ""):
            temp = ""
        else: 
            temp = ("{:12s}"*(sep+1)).format("",*filt)
            
        print("after:",temp)
        lines[i] = temp
    formatted_lines = [line.upper() + '\n' for line in lines]
    


    with open(file_path, 'w') as file:
        file.writelines(formatted_lines)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: format_asm.py <file_path>")
        sys.exit(1)
    
    format_assembly_file(sys.argv[1])
