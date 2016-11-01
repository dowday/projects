__author__ = 'zeroday'
import sys
import collections

wordfreqs = collections.defaultdict(int)
with open('./gene/gene.train', 'r') as f:
	for line in f:
		line = line.strip()
		if line != "":
			wordfreqs[line.split(" ")[0]] += 1
	rarewords = [w for w in wordfreqs if wordfreqs[w] < 5]
with open('./gene/gene.train', 'w+') as f2:
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
