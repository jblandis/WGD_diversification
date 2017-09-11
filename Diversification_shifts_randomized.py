import random

#create log file to write summed values after each generation
log_file = open("Four_node_lag_permutation.txt", "w")

#create a dictionary with all of the nodes that an upshift occurs
keys = []
values = []
#open the file text file with nodes in one column and the second column having a 1 to demonstrate a shift; 
#strip out new line information
with open("Four_node_lag.txt", "r") as f:
	words = [word.strip() for word in f]
# for each line in the file, the first column is added to keys, and the second column to the values variable
for line in words:
	code = line.split("\t")
	keys.append(code[0])
	values.append(code[1])
#this creates the dictionary from keys and values varibles
new_dict = {k: v for k, v in zip(keys, values)}

#open text document that was made listing all possible nodes where a WGD could occur in order, all nodes in one column
nodes = open("Nodes.txt", "r")
lines = []
for line in nodes:
	data = line.split("\n")
	WGD = data[0]
	lines.append(WGD)

#perform 100,000 randomizations selecting 251 nodes to be randomized shifts in diversification. 	
for x in range(1,100001):
	rando = random.sample(lines,251)
	#print(rando)
	#use randomize numbers to find the keys and values for the selected events
	n = {k: new_dict[k] for k in new_dict.keys() & set(rando)}

	#save all values from randomized in a variable
	m = n.values()

	#scroll through the variable, count all the randomized nodes and add up all that have a 1, representing a match
	total = 0
	for i in m:
		total = total + int(i)
	
	log_file.write(str(total)+ "\n")	
