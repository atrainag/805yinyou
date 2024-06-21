import sys
import os

def convert(input_file,output_file,melo,bass):
    dictionary = {" ":"BLK"}
    #translationFile = r'.\PianoSheets\BadApple\Translation.txt'
    translationFile = 'V2HTranslation.txt'
    with open(translationFile,'r')as translfile:
        for i in (translfile.readlines()):
            key, val = i.strip().split()
            dictionary[key] = val

    with open(input_file,'r') as inpfile:
        lines = inpfile.read()
        
    lines = lines.replace('[',"").split("]")
    melodyV = []
    bassV = []
    melodyH = []
    bassH = []
    for i in range(len(lines)):
        #print(lines[i])
        if(len(lines[i])==2):
            bassV.append(lines[i][0])
            melodyV.append(lines[i][1])
        elif(len(lines[i])==0):
            continue
        else:
            bassV.append(lines[i][0]) 
            melodyV.append(" ")
    for i in melodyV:
        melodyH.append(dictionary[i])

    for i in bassV:
        bassH.append(dictionary[i])

    with open(output_file, 'w') as outfile:
        outfile.write("MELODY Virtual Piano:\n")
        outfile.write("".join(melodyV))
        outfile.write("\n\nBASS Virtual Piano:\n")
        outfile.write("".join(bassV))
        outfile.write("\n\nMELODY Human:\n")
        outfile.write(" ".join(melodyH))
        outfile.write("\n\nBASS Human:\n")
        outfile.write(" ".join(bassH))
    with open(melo,'w') as mel:
        mel.write(" ".join(melodyH))
    with open(bass,'w') as bas:
        bas.write(" ".join(bassH))

'''#VSCODE
input_file = r'.\PianoSheets\BadApple\BadAppleSong.txt'
output_file = r'.\PianoSheets\BadApple\BadAppleSongHuman.txt'
output_melody = r'.\PianoSheets\BadApple\BadAppleMelody.txt'
output_bass= r'.\PianoSheets\BadApple\BadAppleBass.txt'
'''

input_file = 'BadAppleSong.txt'
output_file = 'BadAppleSongDebug.txt'
output_melody = 'BadAppleMelody.txt'
output_bass= 'BadAppleBass.txt'

convert(input_file, output_file,output_melody,output_bass)
