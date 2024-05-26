import sys

def convert(input_file, output_file):
    with open(input_file, 'r') as infile:
        lines = infile.read()
    lines = lines.split() 
    with open(output_file, 'w') as outfile:
        cnt = 0
        for i in lines:
            if(cnt == 0):
                outfile.write("DB ")     
            outfile.write()
        
# Specify the input and output filenames
input_file = r'.\PianoSheets\BadApple\BadAppleMelody.txt'
output_file = r'.\PianoSheets\BadApple\BadAppleMelody.a51'

# Process the DLSL data
convert(input_file, output_file)
