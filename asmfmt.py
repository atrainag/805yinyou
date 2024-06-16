#!/usr/bin/env python3
import sys
import os
import glob

def format_assembly_file(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    for i in range(len(lines)):
        temp = lines[i].replace('\n',' ').replace('\t',' ').split(" ")
        filt = list(filter(lambda x: x!="",temp))
        for j in range(len(filt)):
            filt[j] = filt[j].replace(" ","")
        b = "|".join(filt)
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
        filt = c.split(" ")  
        sep = len(filt) 
        funcHead = ":" in filt[0]
        if(funcHead):
            if(sep>=2):
                temp = ("{:12s}"*(2)+" {:s}"*(sep-2)).format(*filt)
            else:
                temp = ("{:12s}"*(sep)).format(*filt)
        elif(len(filt) <= 1 and filt[0] == ""):
            temp = ""
        elif(filt[0][0] == ';'):
            temp = " ".join(filt)
        else: 
            if(sep >= 2):
                temp = ("{:12s}"*(2)+" {:s}"*(sep-1)).format("",*filt)
            else:
                temp = ("{:12s}"*(sep+1)).format("",*filt)
        lines[i] = temp
    formatted_lines = [line.upper() + '\n' for line in lines]
    with open(file_path, 'w') as file:
        file.writelines(formatted_lines)


def format_directory(directory_path):
    asm_files = glob.glob(os.path.join(directory_path, '**', '*.a51'), recursive=True) + \
                glob.glob(os.path.join(directory_path, '**', '*.asm'), recursive=True)
    for asm_file in asm_files:
        format_assembly_file(asm_file)


if __name__ == "__main__":
    if (len(sys.argv) != 3 and len(sys.argv)!=2):
        print("Usage: format_asm.py -f <file_path> or format_asm.py -d <directory_path>")
        sys.exit(1)
    
    if(len(sys.argv)==2):
        path = sys.argv[1]
        if(path[path.find("."):] in [".asm",".a51"]):
            format_assembly_file(sys.argv[1])
        else:
            print("File type not supported, make sure its a51 or asm file")
        sys.exit(1)

    option = sys.argv[1]
    path = sys.argv[2]

    if len(sys.argv) == 2 or option == '-f' or option == '--file':
        format_assembly_file(path)
    elif option == '-d' or option == '--directory':
        format_directory(path)
    else:
        print("Invalid option. Use -f for file or -d for directory.")
        sys.exit(1)
