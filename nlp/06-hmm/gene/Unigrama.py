__author__ = 'mod'
import sys
import collections

frecdt = collections.defaultdict(int)
with open('C:/Users/mod/OneDrive/2015-2016/Uni/AutumnSem2015/iTALN/TALN_TP/TP6-HMM/gene/gene.train', 'r') as f:
	for line in f:
		line = line.strip()
		if line != "":
			frecdt[line.split(" ")[0]] += 1
	rarewords = [w for w in frecdt if frecdt[w] < 5]
with open('C:/Users/mod/OneDrive/2015-2016/Uni/AutumnSem2015/iTALN/TALN_TP/TP6-HMM/gene/gene.train', 'w+') as f2:
	for line in f2:
		line = line.strip()
		if line == "":
			f2.write("\n")
		else:
			elements = line.split(" ")
			if elements[0] in rarewords:
				if len(elements) > 1:
					f2.write("{} {}\n".format("_RARE_", elements[1]))
				else:
					f2.write("_RARE_\n")
			else:
				f2.write(line + "\n")
