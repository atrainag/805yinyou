
def generate_chk(note_number,note):
    chk_code = (
        f"CHK{note_number}:       CJNE        A,          #{note_number},        CHK{note_number + 1}\n"
        f"            ACALL       {note}\n"
    )
    return chk_code

def process_dlsl_for_chk(input_file, output_file):
    with open(input_file, 'r') as infile:
        lines = infile.readlines()

    with open(output_file, 'w') as outfile:
        for i, line in enumerate(lines):
            parts = line.split()
            if len(parts) == 3:
                note_number = i + 1
                chk_code = generate_chk(note_number,parts[0])
                outfile.write(chk_code)

        # Write the last CHK without further CJNE
        final_chk = f"CHK{note_number + 1}:       NOP\n"
        outfile.write(final_chk)

# Specify the input and output filenames
input_file = 'DLSL2.txt'
output_file = 'generatedCheckNotes2.a51'

# Process the DLSL data to generate CHK
process_dlsl_for_chk(input_file, output_file)
