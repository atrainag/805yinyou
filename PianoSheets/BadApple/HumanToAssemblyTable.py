import sys

def convert(input_file, output_file):
    dictionary = {}
    translationFile = "TranslationHumanToNoteCode.txt"
    with open(translationFile, 'r') as translfile:
        cnt = 0
        for i in translfile.readlines():
            dictionary[i.strip()] = cnt
            cnt+=1
    with open(input_file, 'r') as infile:
        lines = infile.read()

    lines = lines.split() 
    with open(output_file, 'w') as outfile:
        cnt = 0
        for i in lines:
            if(cnt == 0):
                outfile.write("DB ")     
            outfile.write(str(dictionary[i])+",")
            outfile.write("2")
            cnt += 1
            if(cnt == 4): 
                outfile.write("\n")
                cnt = 0
            else:
                outfile.write(',')

# Specify the input and output filenames
input_file = "BadAppleBass.txt"
output_file = "BadAppleBassTable.a51"

# Process the DLSL data
convert(input_file, output_file)
