from __future__ import division

from datetime import datetime
import re
import sys
import itertools
import csv
import os

#start time
startTime = datetime.now()


#the next few lines sets to open the file with the barcodes and samples
#first create
keys = []
values = []
#open a file of all genera of interest, in this case it is all the unique genera names from Zanne et al. 2014, originally had it so that there
#are two columns that are unique, with "Genus" as the header in each
with open("Unique_genera.txt", "r") as f:
	words = [word.strip() for word in f]
# for each line in the file, the second column is added to keys, and the third column to the values variable
for line in words:
	code = line.split("\t")
	keys.append(code[1])
	values.append(code[1])
#remove the first entry in each list which is essentially the headers Sample and Sequence used in the Barcode file
keys.remove("Genus")
values.remove("Genus")
#this creates the dictionary from keys and values varibles
new_dict = {k: v for k, v in zip(keys, values)}


for key,val in new_dict.items():
	fname = val
	BC = key
#creates the variable filePath, which tells the script where to write the new files, one for each barcode			
	filePath = '/Users/jacoblandis/Desktop/WGD_Diversification/Plant_List/Genera/%s.txt' % (fname)
	f = open(filePath, 'w')
	f.close		

#create a log file for species with "Accepted" as their status	
accepted_entries = open("/Users/jacoblandis/Desktop/WGD_Diversification/Plant_List/Accepted_species.txt", "w")

	

g_and_s = open("/Users/jacoblandis/Desktop/WGD_Diversification/Plant_List/Family_docs/Cleaned_families.txt", "r")
for line in g_and_s:
	data = line.split("\t")
	genus = data[0]
	species = data[1]
	status = data[2]
	
	if re.match("Accepted", status):
		accepted_entries.write(genus + "\t" + species + "\n")
		
		
accept = open("Accepted_species.txt", "r")
for line in accept:
	rank = line.split("\t")
	Genus = rank[0]
	Species = rank[1]
	d = new_dict.get(Genus)
	filePath = '/Users/jacoblandis/Desktop/WGD_Diversification/Plant_List/Genera/%s.txt' % (d)
	f = open(filePath, 'a')	
	f.write(Species)
	f.close

log_file = open("Log_file_of_all_genera.txt", "w")	
for entry in values:
	final_count = 0	
	filePath = '/Users/jacoblandis/Desktop/WGD_Diversification/Plant_List/Genera/%s.txt' % (entry)
	f = open(filePath, 'r')	
	for line in f:
		if re.search(".",line):
			final_count = final_count + 1
	log_file.write(entry + "\t" + str(final_count) + "\n")
			
