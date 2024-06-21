import sys

def convert(input_file, output_file):
    dictionary = {}
    #translationFile = r".\PianoSheets\BadApple\TranslationHumanToNoteCode.txt"
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
        totcnt = 0
        for i in lines:
            if(cnt == 0):
                outfile.write(" DB ")     
            outfile.write(str(dictionary[i])+",")
            outfile.write("1")
            cnt += 1
            totcnt+=1
            if(cnt == 4 or totcnt == len(lines)): 
                outfile.write("\n")
                cnt = 0
            else:
                outfile.write(',')

#input_file = r'.\PianoSheets\BadApple\BadAppleBass.txt'
#output_file = r'.\PianoSheets\BadApple\BadAppleBassTable.a51'

input_file = 'BadAppleBass.txt'
output_file = 'BadAppleBassTable.a51'
convert(input_file, output_file)

#input_file = r'.\PianoSheets\BadApple\BadAppleMelody.txt'
#output_file = r'.\PianoSheets\BadApple\BadAppleMelodyTable.a51'

input_file = 'BadAppleMelody.txt'
output_file = 'BadAppleMelodyTable.a51'
convert(input_file, output_file)
