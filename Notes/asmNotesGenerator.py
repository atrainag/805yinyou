def generate_asm(note, delay_length, sound_length):
    asm_code = (
        f"{note}: MOV R6,#{int(delay_length)}\n"
        f"              MOV R5,#{int(sound_length)}\n"
        f"              AJMP OUTPUT\n"
    )
    return asm_code

def process_dlsl(input_file, output_file):
    with open(input_file, 'r') as infile:
        lines = infile.readlines()

    with open(output_file, 'w') as outfile:
        for line in lines:
            parts = line.split()
            if len(parts) == 3:
                note = parts[0]
                delay_length = float(parts[1])
                sound_length = float(parts[2])
                asm_code = generate_asm(note, delay_length, sound_length)
                outfile.write(asm_code)

# Specify the input and output filenames
input_file = 'DLSL.txt'
output_file = 'generateAsmNotes.a51'

# Process the DLSL data
process_dlsl(input_file, output_file)
