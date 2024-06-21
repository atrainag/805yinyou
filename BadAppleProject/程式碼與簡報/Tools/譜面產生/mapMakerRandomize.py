import random

#song = r".\PianoSheets\BadApple\BadAppleMelody.txt"
song = "BadAppleMelody.txt"

with open(song,'r') as notes:
    table = notes.readlines()
table = table[0].split()
#print("Table:",table)
beatmap = []
for i in table:
    if(i == "BLK"):
        beatmap.append("11111111") #控
    else:
        rand = random.randint(0,3)
        if(rand == 0) :
            beatmap.append("00111111") #最左邊
        elif(rand == 1) :
            beatmap.append("11001111") #中做
        elif(rand == 2) : 
            beatmap.append("11110011") #中右
        elif(rand == 3) :
            beatmap.append("11111100") #最右邊
    beatmap.append("11111111")

#out_file= r".\PianoSheets\BadApple\BadAppleMapRandom.txt"
out_file = "BadAppleMapRandom.txt"
with open(out_file,'w') as out:
    for i in beatmap:
        out.write(" DB "+i+"B\n")
