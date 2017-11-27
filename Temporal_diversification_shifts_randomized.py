import random

#create log file to write summed values after each generation
log_file = open("Window_four_permutation_downshifts_only.txt", "w")
log_file

#lst = []

#for i in range(7860,15718):
#	lst.append(i)

#create a dictionary with all of the nodes that an upshift occurs
keys = []
values = []
#The dictionary file contains all the nodes present in the four sliding windows of time
#window one is 0-8 MY
#window tow is 8.1-26.3 MY
#window three is 26.4-51.4 MY
#window four is 51.5-114.2 MY
#open the file text file with nodes and shifts, and strip out new line information
with open("Window_four.txt", "r") as f:
	words = [word.strip() for word in f]
# for each line in the file, the second column is added to keys, and the third column to the values variable
for line in words:
	code = line.split("\t")
	keys.append(code[0])
	values.append(code[1])
#this creates the dictionary from keys and values varibles
new_dict = {k: v for k, v in zip(keys, values)}

#open text document that was made listing all internal nodes
nodes = open("Nodes.txt", "r")
lines = []
for line in nodes:
	data = line.split("\n")
	WGD = data[0]
	lines.append(WGD)

#change the number of lines to the number of shifts expected
#for all shifts, that is 334
#for upshifts only, that is 251
#for downshifts only, that is 83
for x in range(1,100001):
	rando = random.sample(lines,83)
	#print(rando)
	#use randomize numbers to find the keys and values for the selected events
	n = {k: new_dict[k] for k in new_dict.keys() & set(rando)}

	#save all values from randomized in a variable
	m = n.values()

	total = 0
	for i in m:
		total = total + int(i)
	
	log_file.write(str(total)+ "\n")	
	 
	#random.shuffle(WGD)
#	print(str(WGD))