import os

#create a dictionary with all of the nodes that an upshift occurs
keys = []
values = []
#open the file text file with species in one column and number of species in the second column, and strip out new line information
with open("SpeciesRichness.txt", "r") as f:
	words = [word.strip() for word in f]
# for each line in the file, the first column is added to keys, and the second column to the values variable
for line in words:
	code = line.split("\t")
	keys.append(code[0])
	values.append(code[1])
#this creates the dictionary from keys and values varibles
new_dict = {k: v for k, v in zip(keys, values)}

#path of folder with all descendant files generated in R
folder_path = '/Users/jacoblandis/Desktop/SisterCladeSim/Descendant_files'

#open each file path sequentially, attempt to match descendant node to dictionary, if matching, add that number of species.  If no match,
#report a 0 for that row
for data_file in sorted(os.listdir(folder_path)):
	filename = "%s" %data_file
	filepath = '/Users/jacoblandis/Desktop/SisterCladeSim/Descendant_files/%s' % (data_file)
	f = open(filepath, "r")
	logfile = open(filename, "w")
	for line in f:
		data = line.split("\n")
		WGD = data[0]
		species = new_dict.get(WGD, "0")
		logfile.write(str(species) + "\n")
		logfile.close


#open count files for each node, sum them up and report back in a single log file		
Count_log = open("Count_log.txt", "w")
parsed_path = '/Users/jacoblandis/Desktop/SisterCladeSim/Parsed_data'
for data_file2 in sorted(os.listdir(folder_path)):
	filepath = '/Users/jacoblandis/Desktop/SisterCladeSim/Parsed_data/%s' % (data_file2)
	f2 = open(filepath, "r")
	counts = []
	for line in f2:
		data = line.split("\n")
		spec = data[0]
		counts.append(spec)
	split_string = list(map(int,counts))
	total_species = sum(split_string)
	Count_log.write(str(total_species) + ' species in %s' % (data_file2) + "\n")	
	
