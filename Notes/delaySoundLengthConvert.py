
def calculate_dl_sl(freq):
    dl = ((500000 / freq) - 9) / 15
    sl = freq / 8
    return round(dl), round(sl)

def process_notes(input_file, output_file):
    with open(input_file, 'r') as infile:
        lines = infile.readlines()

    with open(output_file, 'w') as outfile:
        for line in lines:
            parts = line.split()
            if len(parts) == 2 and parts[1].isdigit():
                note = parts[0]
                freq = int(parts[1])
                dl, sl = calculate_dl_sl(freq)
                outfile.write(f"{note:3s} {dl:3d} {sl:3d}\n")

# Specify the input and output filenames
input_file = 'Notes.txt'
output_file = 'DLSL.txt'

# Process the notes
process_notes(input_file, output_file)
