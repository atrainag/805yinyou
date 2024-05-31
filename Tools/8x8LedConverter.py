import sys

def convert8x8(file_path,out_path):
    with open(file_path,'r') as files:
        original = files.readlines()
    original = [i.strip() for i in original]
    result = [""]*8
    for i in range(0,8):
        for j in range(0,8):
            result[i] += original[j][i]
    result = result[::-1] 
    result = [f"{'':11s}{'DB':12s}{i+"B\n":11s}" for i in result]
    result[0] = " "+result[0]
    with open(out_path,"w") as outFile:
        for i in result:
            outFile.write(i)
            print(i)
file_path = "draw8x8.txt"
out_path = f"converted_{file_path}"
convert8x8(file_path,out_path)
