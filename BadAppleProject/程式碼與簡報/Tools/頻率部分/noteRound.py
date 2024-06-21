def round_numbers_in_file(filename,output_filename):
    with open(filename, 'r') as file:
        lines = file.readlines()

    with open(output_filename, 'w') as file:
        for line in lines:
            parts = line.split()
            if len(parts) == 2 and parts[1].replace('.', '', 1).isdigit():
                rounded_number = round(float(parts[1]))
                file.write(f"{parts[0]} {rounded_number}\n")
            else:
                file.write(line)

# Specify the filename
filename = 'NotesFreq.txt'
output_filename = 'NotesFreqRounded.txt'
round_numbers_in_file(filename,output_filename)
